### SNCF DELAYS: Data Preparation ###

# Required Packages
library(tidyverse)
library(ggmap)

# Train Data
trains <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-26/full_trains.csv")

write.csv(trains, "trains.csv", row.names = FALSE)

# Get Station Names
station_names <- trains %>%
  distinct(departure_station) %>%
  rename("station" = "departure_station")

write.csv(station_names, "station_names.csv", row.names = FALSE)

# Upload Station Info (region, population, address)
station_info <- read_csv("station_info.csv")

# Get Station Coordinates
station_info$lon <- 0
station_info$lat <- 0
for(i in 1:nrow(station_info)){
  result <- geocode(station_info$address[i], output = "latlona", source = "google")
  station_info$lon[i] <- as.numeric(result[1])
  station_info$lat[i] <- as.numeric(result[2])
}

write.csv(station_info, "station_loc.csv", row.names = FALSE)

