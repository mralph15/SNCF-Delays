### SNCF: UI ###

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

# UI
ui <- dashboardPage(
  skin = "black",
  dashboardHeader(
    title = "SNCF Delays"
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "About",
        tabName = "about",
        icon = icon("book")
      ),
      menuItem(
        "Mapping",
        tabName = "mapping",
        icon = icon("map")
      ),
      menuItem(
        "Modeling",
        tabName = "modeling",
        icon = icon("chart-line")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "about",
        h2("About"),
        fluidRow(
          box(
            width = 12,
            h3("This is a test message.")
          )
        )
      ),
      tabItem(
        tabName = "mapping",
        h2("Mapping"),
        fluidRow(
          box(
            column(6,
                   selectInput("map_year", "Select year:", c(2015, 2016, 2017, 2018))
            ),
            column(6,
                   selectInput("map_month", "Select month:",
                               c("Jan" = 1, "Feb" = 2, "Mar" = 3, "Apr" = 4,
                                 "May" = 5, "Jun" = 6, "Jul" = 7, "Aug" = 8,
                                 "Sep" = 9, "Oct" = 10, "Nov" = 11, "Dec" = 12))
            ),
            checkboxInput("map_select", "Averages for only delayed trains", FALSE)
          )
        ),
        fluidRow(
          box(
            column(6,
                   plotOutput("dep_map")),
            column(6,
                   plotOutput("arrival_map")),
            width = 12
          )
        )
      ),
      tabItem(
        tabName = "modeling",
        h2("Modeling")
      )
    )
  )
)