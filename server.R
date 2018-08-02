library(shiny)
library(dplyr)
library(magrittr)

server <- function(input, output){
  output$maintable <- renderDataTable(expr = {
      allData <- allData %>% filter(year >= input$year[1], year <= input$year[2])
    })
}