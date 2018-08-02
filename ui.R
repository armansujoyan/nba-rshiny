library(shiny)
library(shinydashboard)

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
