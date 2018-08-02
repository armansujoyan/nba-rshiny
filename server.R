library(shiny)
library(dplyr)
library(magrittr)
library(ggplot2)

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
  
  output$comparison <- renderPlot({
    players <- allData  %>% filter(PLAYER %in% c(input$player1,input$player2))
    plot <- ggplot(data = players) + geom_bar(aes(x=PLAYER,y=GP),position="dodge",stat="identity")
    print(plot)
  })
}

