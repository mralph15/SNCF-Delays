### SNCF: UI ###

# Reqired Packages
library(shiny)
library(shinydashboard)
library(tidyverse)

# Load data
trains <- read_csv("data/trains.csv")

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
        box(
          width = 12,
          h3("This is a test message.")
        )
      ),
      tabItem(
        tabName = "mapping",
        h2("Mapping")
      ),
      tabItem(
        tabName = "modeling",
        h2("Modeling")
      )
    )
  )
)