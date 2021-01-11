#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("TABS!"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("box1", "Enter Tab 1 Text:", value = "Tab 1!"),
       textInput("box2", "Enter Tab 2 Text:", value = "Tab 2!"),
       textInput("box3", "Enter Tab 3 Text:", value = "Tab 3!")
          ),
    
    # Show a plot of the generated distribution
    mainPanel(
       tabsetPanel(type = "tabs",
                   tabPanel("Tab 1", br(), textOutput("out1")),
                   tabPanel("Tab 2", br(), textOutput("out2")),
                   tabPanel("Tab 3", br(), textOutput("out3"))
                   )
    )
  )
))
