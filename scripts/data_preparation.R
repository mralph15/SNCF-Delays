### SNCF DELAYS: Data Preparation ###

# Required Packages
library(tidyverse)
library(ggmap)

# Train Data
trains <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-26/full_trains.csv")

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

# Merge stations' info + trains data
arrival <- left_join(trains, station_info, by = c("arrival_station" = "station")) %>%
  rename("arrival_region" = "region",
         "arrival_pop" = "pop",
         "arrival_lat" = "lat",
         "arrival_lon" = "lon") %>%
  select(-address)

trains_new <- left_join(arrival, station_info, by = c("departure_station" = "station")) %>%
  rename("dep_region" = "region",
         "dep_pop" = "pop",
         "dep_lat" = "lat",
         "dep_lon" = "lon") %>%
  select(-address)

# Add seasonality indicator
trains_new <- trains_new %>%
  mutate(season = case_when(month %in% c(12, 1, 2) ~ "Win",
                            month %in% c(3, 4, 5) ~ "Spr",
                            month %in% c(6, 7, 8) ~ "Sum",
                            TRUE ~ "Fal"))

# Save cleaned data file
write.csv(trains_new, "trains.csv", row.names = FALSE)
