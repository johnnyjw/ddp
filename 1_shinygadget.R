library(shiny)
library(miniUI)

myFirstGadget <- function(){
  ui <- miniPage(
    gadgetTitleBar("My First Gadget")
  )
  server <- function(input, output, session) {
    # The Done button closed the app
    observeEvent(input$done, {
      stopApp()
    })
  }
  runGadget(ui, server)
}

myFirstGadget()


