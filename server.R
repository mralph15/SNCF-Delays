### SNCF: SERVER ###

# Reqired Packages
library(shiny)
library(shinydashboard)
library(tidyverse)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)
library(rgeos)

# Load data
trains <- read_csv("data/trains.csv")
world <- ne_countries(scale = "medium", returnclass = "sf")

# SERVER
server <- function(input, output){
  # About
  # Mapping
  output$dep_map <- renderPlot({
    tmp <- trains %>%
      filter(year == input$map_year,
             month == input$map_month) %>%
      group_by(departure_station) %>%
      summarise(avg_delay_all_departing = mean(avg_delay_all_departing),
                avg_delay_late_at_departure = mean(avg_delay_late_at_departure),
                dep_lon = min(dep_lon),
                dep_lat = max(dep_lat))
    
    if(input$map_select == FALSE){
      ggplot(data = world) +
        geom_sf(fill = "cornsilk") +
        geom_point(data = tmp,
                   aes(x = dep_lon, y = dep_lat, size = avg_delay_all_departing),
                   alpha = 0.6, position = position_jitter(h = 0.2, w = 0.2)) +
        labs(size = "Average Delay (mins)", title = "Delay at Departure") +
        coord_sf(xlim = c(-8.4, 11), ylim = c(40.5, 50.7)) +
        theme_void() + 
        theme(legend.position = c(0.2, 0.5),
              plot.title = element_text(size = 16, hjust = 0.5,
                                        margin = margin(0, 0, 5, 0)))
    }
    else{
      ggplot(data = world) +
        geom_sf(fill = "cornsilk") +
        geom_point(data = tmp,
                   aes(x = dep_lon, y = dep_lat, size = avg_delay_late_at_departure),
                   alpha = 0.6, position = position_jitter(h = 0.2, w = 0.2)) +
        labs(size = "Average Delay (mins)", title = "Delay at Departure") +
        coord_sf(xlim = c(-8.4, 11), ylim = c(40.5, 50.7)) +
        theme_void() + 
        theme(legend.position = c(0.2, 0.5),
              plot.title = element_text(size = 16, hjust = 0.5,
                                        margin = margin(0, 0, 5, 0)))
    }
  })
  
  output$arrival_map <- renderPlot({
    tmp2 <- trains %>%
      filter(year == input$map_year,
             month == input$map_month) %>%
      group_by(arrival_station) %>%
      summarise(avg_delay_all_arriving = mean(avg_delay_all_arriving),
                avg_delay_late_on_arrival = mean(avg_delay_late_on_arrival),
                arrival_lon = min(arrival_lon),
                arrival_lat = max(arrival_lat))
    
    if(input$map_select == FALSE){
      ggplot(data = world) +
        geom_sf(fill = "cornsilk") +
        geom_point(data = tmp2,
                   aes(x = arrival_lon, y = arrival_lat, size = avg_delay_all_arriving),
                   alpha = 0.6, position = position_jitter(h = 0.2, w = 0.2)) +
        labs(size = "Average Delay (mins)", title = "Delay on Arrival") +
        coord_sf(xlim = c(-8.4, 11), ylim = c(40.5, 50.7)) +
        theme_void() + 
        theme(legend.position = c(0.2, 0.5),
              plot.title = element_text(size = 16, hjust = 0.5,
                                        margin = margin(0, 0, 5, 0)))
    }
    else{
      ggplot(data = world) +
        geom_sf(fill = "cornsilk") +
        geom_point(data = tmp2,
                   aes(x = arrival_lon, y = arrival_lat, size = avg_delay_late_on_arrival),
                   alpha = 0.6, position = position_jitter(h = 0.2, w = 0.2)) +
        labs(size = "Average Delay (mins)", title = "Delay on Arrival") +
        coord_sf(xlim = c(-8.4, 11), ylim = c(40.5, 50.7)) +
        theme_void() + 
        theme(legend.position = c(0.2, 0.5),
              plot.title = element_text(size = 16, hjust = 0.5,
                                        margin = margin(0, 0, 5, 0)))
    }
  })
  
  # Modeling
}

