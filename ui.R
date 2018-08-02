library(shiny)
library(shinydashboard)

sidebar <- dashboardSidebar(
  sidebarMenu(
    sliderInput(inputId = "year", 
                label = "Years", 
                min = 2000, max = 2017, 
                value = c(2000, 2017))
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
  includeCSS('styles.css'),
  dashboardHeader(title = 'Analysis of NBA stats'), sidebar, body
)

shinyApp(ui, server)
