library(shiny)

ui <- fluidPage(
  titlePanel("NBA Players Statistics"),
  fluidRow(
    column(8, tabsetPanel(type = "tabs",
                          tabPanel("Leaders table", tableOutput("allplayers")),
                          tabPanel("Compare Players"),
                          tabPanel("Top players"),
                          tabPanel("Individual")
    )),
    column(4, selectInput(inputId = "season", label = "Season",
                          choices = seasons, selected = "2010-11" ),
           radioButtons("seasontype", label = h3("Season Type"),
                        choices = seasonType, selected = "Regular Season"),
           radioButtons("pergame", label = h3("Per Mode"),
                        choices = perMode, selected = "Per Game"))
  )
)

shinyApp(ui, server)
