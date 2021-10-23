library(shiny)
library(tidyverse)
library(readxl)
library(ggplot2)


setwd('C:/Users/johnny/Documents/Dat_Sci/ddp/4_ass/volcanoes')

max_countries <- 30
min_year <- 1850
max_year <- 2021
country_continent <- "Country / Dependency"
country_continent <- "Continent"
c_e <- if_else(country_continent == "Continent", 
               "Continent",
               "Entity")


cont <- read_excel('continents.xlsx')
erupt <- read.csv('significant-volcanic-eruptions.csv') %>% 
  rename('erupt' = "Number.of.significant.volcanic.eruptions..NGDC.WDS.")

comb_erupt <- erupt %>% 
  left_join(cont %>% select(Code, Continent), by = "Code") %>% 
  filter(! is.na(Continent))

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
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  ggtitle(paste0("Total Significant Volcanic Eruptions between ", 
                 min_year,
                 " and ",
                 max_year,
                 " by ",
                 country_continent)) +
  xlab(country_continent) +
  ylab("Number of Eruptions")


# need to turn the x axis labels - DONE
# order by frequency - DONE
# rank - DONE
# labels - DONE
# variables for settings - DONE
# labels for graph, Axes - DONE
# entity/continent switch
