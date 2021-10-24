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
    titlePanel("Total Number of Significant Volcanic Eruptions"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("year_range",
                        "Year Range:",
                        min = 0,
                        max = 2100,
                        value = c(0, 2022)),
            numericInput("top_bars",
                         "Maximum number of regions displayed",
                         7),
            radioButtons("country_continent",
                         "Select to display Country/Regions or Continents",
                         choiceNames = c("Country/Region", "Continent"),
                         choiceValues = c("Entity", "Continent"),
                         selected = "Entity")
        ),

        # Show a plot of the generated distribution
        mainPanel(
          tabsetPanel(type = "tabs",
                      tabPanel("Plot",
                                plotOutput("distPlot")),
                      tabPanel("Table",
                               tableOutput("volcTable")),
                      tabPanel("Documentation",
                               tags$div(class="header", checked=NA,
                                        tags$p("Number of Significant Volcano Eruptions*")),
                               tags$div(class="body", checked=NA,
                                        tags$p("This app displays total significant volcano eruptions either
                                               as a bar chart (click <Plot> tab) or a table (Click <Table> tab)."),
                                        tags$p("To View the total number of eruptions within a range of years, use the <Year Range> slider.  
                                               The left slider controls the minimum year in the range and the right slider controls the maximum year in the range."),
                                        tags$p("To limit the number of Countries/Regions, or Continents displayed, use the <Maximum number of regions displayed> controller. 
                                               This can be adjusted by using the <up> <down> controls or typing a number into the box. If the entered number is greater than 
                                               the maximum number of regions on the table then the number of items displayed will not match the entered number."),
                                        tags$p("To display the volcanic eruptions total by either country/region or continent, use the buttons under <Select to 
                                               display Country/Regions or Continents>.  You can toggle between these two modes on both the Plot and the Table."),
                                        tags$p("*A significant eruption is classified as one that meets at least one of the following criteria: caused fatalities, 
                                        caused moderate damage (approximately $1 million or more), with a Volcanic Explosivity Index (VEI) of 6 or larger, caused a tsunami, 
                                               or was associated with a major earthquake."),
                                        tags$a(href = "https://github.com/johnnyjw/ddp/tree/main/4_ass/volcanoes", "The server.R and ui.R can be found here"))
                               ))
          )
    ),
    print("Source: National Geophysical Data Center / World Data Service (NGDC/WDS): NCEI/WDS Global Significant Volcanic Eruptions Database. NOAA National Centers for Environmental Information. doi:10.7289/V5JW8BSH")
)
)
