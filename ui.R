library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title="NBA Player Statistics"),
  dashboardSidebar(selectInput(inputId = "season", label = "Season",
                               choices = seasons, selected = "2010-11" ),
                   radioButtons("seasontype", label = h3("Season Type"),
                                choices = seasonType, selected = "Regular Season"),
                   radioButtons("permode", label = h3("Per Mode"),
                                choices = perMode, selected = "Per Game")),
  dashboardBody(includeCSS("styles.css"),
                titlePanel("NBA Players Statistics"),
                tabsetPanel(type = "tabs",
                            tabPanel("Leaders table",
                                     dataTableOutput("allplayers")),
                            tabPanel("Compare Players"),
                            tabPanel("Top players"),
                            tabPanel("Individual"))
                ),
)

shinyApp(ui, server)
