library(shiny)
library(dplyr)
library(magrittr)

server <- function(input, output){
  output$allplayers <- renderTable({
    current_data <- current_data %>% select(-PLAYER_ID)
  })
}
