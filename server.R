library(shiny)
library(dplyr)
library(magrittr)

server <- function(input, output){
  output$maintable <- renderDataTable(expr = {
      allData <- allData %>% filter(year >= input$year[1], year <= input$year[2],
                                    GP >= input$gamesplayed[1], GP <= input$gamesplayed[2],
                                    PTS >= input$points[1], PTS <= input$points[2],
                                    EFF >= input$eff[1], year <= input$eff[2])
      if(input$team != 'All teams'){
        allData <- allData %>% filter(TEAM == input$team)
      }
      allData
    })
}