library(shiny)
library(dplyr)
library(magrittr)

server <- function(input, output){
  output$allplayers <- renderDataTable({
    allData
  })
}
