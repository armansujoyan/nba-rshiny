# Link to the Shiny App https://armansujoyan.shinyapps.io/nba_analysis/
library(shiny)
library(dplyr)
library(magrittr)
library(ggplot2)
library(tidyr)

allData <- read.csv('nbadata.csv', stringsAsFactors = F)

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
    plot <- ggplot(data = players) + geom_bar(aes(x=PLAYER,y=players[,input$compVar]),position="dodge",stat="identity") +
      labs(title = paste(input$player1,' vs ',input$player2,' in ', input$compVar), x = 'Players',
           y = input$compVar) +
      theme(axis.title.x = element_text(size = 20, color= 'black', face= 'bold'),
            axis.title.y = element_text(size = 20, color= 'black', face= 'bold'),
            axis.text.x = element_text(size = 10, color = 'black', face = 'bold'),
            axis.text.y = element_text(size = 10, color = 'black', face = 'bold'),
            plot.title = element_text(size = 20, color= 'black', face= 'bold'),
            legend.title= element_text(size = 10, color= 'black', face= 'bold'),
            legend.text = element_text(size = 10))
    print(plot)
  })
}

