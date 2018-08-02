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
  tabsetPanel(
    type = "tabs",
    tabPanel("Table statistics", dataTableOutput("maintable")),
    tabPanel("Player vs Player"),
    tabPanel("Individual")
  )
)

ui <- dashboardPage(
  dashboardHeader(title = 'Analysis of NBA stats'), sidebar, body
)

shinyApp(ui, server)
