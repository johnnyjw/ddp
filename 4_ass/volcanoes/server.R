#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(readxl)
library(ggplot2)


cont <- read_excel('data/continents.xlsx')
erupt <- read.csv('data/significant-volcanic-eruptions.csv') %>% 
  rename('erupt' = "Number.of.significant.volcanic.eruptions..NGDC.WDS.")

comb_erupt <- erupt %>% 
  left_join(cont %>% select(Code, Continent), by = "Code") %>% 
  filter(! is.na(Continent))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

      max_countries <- input$top_bars
      
      min_year <- input$year_range[1]
      max_year <- input$year_range[2]
      c_e <- input$country_continent
      country_continent <- ifelse(c_e=="Entity",
                                  "Country/Region",
                                  "Continent")
      
      

      
      display_data <- comb_erupt %>%
        filter(Year>=min_year) %>% 
        filter(Year<=max_year) %>% 
        group_by(across(all_of(c_e))) %>% 
        summarize(Eruptions = sum(erupt))  %>%
        ungroup() %>% 
        rename('horizontal' = all_of(c_e))
      
      if (c_e=="Entity"){display_data <- display_data %>%
        left_join(cont %>% select(Country, Continent), by = c("horizontal" = "Country"))}else {display_data <- display_data %>%
          mutate(Continent=horizontal)}
      
      display_data %>% 
        mutate(rank = rank(Eruptions, ties.method="random"),
               reverse_rank = rank(desc(Eruptions), ties.method="random")) %>% 
        filter(reverse_rank<=max_countries) %>% 
        ggplot(aes(reorder(horizontal, rank), 
                   Eruptions, 
                   fill=Continent)) +
        geom_col() + 
        theme(axis.text.x = element_text(angle = 45, hjust=1, size=12),
              axis.title=element_text(size=14),
              plot.title = element_text(size=14)) +
        ggtitle(paste0("Total Significant Volcanic Eruptions between ", 
                       min_year,
                       " A.D. and ",
                       max_year,
                       " A.D. by ",
                       country_continent)) +
        xlab(c_e) +
        ylab("Number of Eruptions")
    })
      output$volcTable = renderTable({
        max_countries <- input$top_bars
        
        min_year <- input$year_range[1]
        max_year <- input$year_range[2]
        c_e <- input$country_continent

        display_data <- comb_erupt %>%
          filter(Year>=min_year) %>% 
          filter(Year<=max_year) %>% 
          group_by(across(all_of(c_e))) %>% 
          summarize(Eruptions = sum(erupt))  %>%
          ungroup()
        
        if (c_e=="Entity"){
          display_data <- display_data %>% 
            left_join(cont %>% select(Country, Continent), by = c("Entity" = "Country")) %>% 
            mutate(rank = rank(Eruptions, ties.method="random"),
                   reverse_rank = rank(desc(Eruptions), ties.method="random")) %>% 
            filter(reverse_rank<=max_countries) %>% 
            select(Entity, Continent, Eruptions) %>% 
            rename(`Country / Region`="Entity") %>% 
            arrange(desc(Eruptions))
        }else{
          display_data <- display_data %>% 
            mutate(rank = rank(Eruptions, ties.method="random"),
                   reverse_rank = rank(desc(Eruptions), ties.method="random")) %>% 
            filter(reverse_rank<=max_countries) %>% 
            select(Continent, Eruptions) %>% 
            arrange(desc(Eruptions))}

        display_data

    })
      


})
