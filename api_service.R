# Getting the API wrapper.
devtools::install_github("abresler/nbastatR", force = T)

# Loading needed libraries
library(nbastatR)
library(jsonlite)
library(rvest)
library(httr)
library(devtools)
library(stringr)

# Function for fetching data
fetchData <- function(season="2017-18",seasonType="Regular Season", permode = "PerGame") {
  # Generating URL's
  league_leaders <- modify_url("https://stats.nba.com/stats/leagueleaders",
                               query = list( LeagueID = "00",
                                             PerMode = permode,
                                             Season = season,
                                             StatCategory = "PTS",
                                             SeasonType = seasonType,
                                             Scope = "RS"))

  dataJSON <- readLines(league_leaders)
  data <- fromJSON(dataJSON)
  if(!is.null(data$resultSets$rowSet[[1]])) {
    data_df <- data$resultSets$rowSet[[1]]
  } else {
    data_df <- data[["resultSet"]][["rowSet"]]
  }
  if (!is.null(data$resultSets$headers[[1]])) {
    colnames(data_df) <- data$resultSets$headers[[1]]
  } else {
    colnames(data_df) <- data[["resultSet"]][["headers"]]
  }
  data_df
}

# Generate seasons list
seasons <- list()
for(i in c(0:7)){
  seasons[i+1] <- paste('201',i,'-1',i+1,sep = "")
}

seasonType <- list("Regular Season","Playoffs","All Star")
perMode <- list("Per Game","Total","Per 36 minutes")

current_data <- fetchData()
current_data <- as.data.frame(current_data)
