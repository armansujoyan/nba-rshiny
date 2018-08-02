# Link to the Shiny App https://armansujoyan.shinyapps.io/nba-stats/
library(shiny)
library(shinydashboard)
library(shiny)
library(dplyr)
library(magrittr)
library(ggplot2)
library(tidyr)
library(jsonlite)
library(rvest)
library(httr)
library(devtools)
library(stringr)

allData <- read.csv('nbadata.csv', stringsAsFactors = F)
allData <- allData %>% select(-X)

server <- function(input, output){
  output$maintable <- renderDataTable(expr = {
    allData <- allData %>% filter(year >= input$year[1], year <= input$year[2],
                                  GP >= input$gamesplayed[1], GP <= input$gamesplayed[2],
                                  PTS >= input$points[1], PTS <= input$points[2],
                                  EFF >= input$eff[1], EFF <= input$eff[2])
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



sidebar <- dashboardSidebar(
  sidebarMenu(
    selectInput("team", label = h3("Team"), 
                choices = c('All teams',unique(allData$TEAM)), 
                selected = 1),
    sliderInput(inputId = "year", 
                label = "Years", 
                min = 2000, max = 2017, 
                value = c(2000, 2017)),
    sliderInput(inputId = "gamesplayed", 
                label = "Games Played", 
                min = 55, max = 83, 
                value = c(55, 83)),
    sliderInput(inputId = "points", 
                label = "Points", 
                min = 1.4, max = 32, 
                value = c(1.4, 32)),
    sliderInput(inputId = "eff", 
                label = "Efficiency", 
                min = 2.4, max = 33.8, 
                value = c(2.4, 33.8))
  )
)

body <- dashboardBody(
  includeCSS('styles.css'),
  tabsetPanel(
    type = "tabs",
    tabPanel("Table statistics", dataTableOutput("maintable")),
    tabPanel("Player vs Player", 
             fluidRow(
               column(6,selectInput("player1", label = h3("Player 1"), 
                                    choices = allData$PLAYER,
                                    selected = 1)),
               column(6,selectInput("player2", label = h3("Player 2"), 
                                    choices = allData$PLAYER,
                                    selected = 1))
             ),
             fluidRow(
               column(12,selectInput('compVar', label = h3('Feature to compare'),
                                     choices = colnames(allData[,5:24])),
                      multiple = TRUE)
             ),
             plotOutput('comparison'))
  )
)

ui <- dashboardPage(
  dashboardHeader(title = 'Analysis of NBA stats'), sidebar, body
)

shinyApp(ui, server)
