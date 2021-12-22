
library(rnaturalearth)
library(sf)
world <- ne_countries(scale = "medium", returnclass = "sf")

ggplot(data = world) +
  geom_sf(fill = "cornsilk") +
  geom_point(data = trains %>% filter(year == 2018, month == 3),
             aes(x = dep_lon, y = dep_lat, size = avg_delay_late_at_departure),
             position = position_jitter(h = 0.2, w = 0.2),
             alpha = 0.6) +
  coord_sf(xlim = c(-8.4, 11), ylim = c(40.5, 50.7)) +
  theme_void() + 
  theme(legend.position = c(0.2, 0.5))

ggplot(data = world) +
  geom_sf(fill = "cornsilk") +
  geom_point(data = trains %>% filter(year == 2018, month == 3),
             aes(x = dep_lon, y = dep_lat, size = avg_delay_late_at_departure),
             position = position_jitter(h = 0.2, w = 0.2),
             alpha = 0.6,
             show.legend = FALSE) +
  coord_sf(xlim = c(2, 3), ylim = c(48, 50)) +
  theme_void()

test <- trains %>%
  filter(year == 2018, month == 3)

#needed --> once a month-year is selected by the user, group by station
#(either depart or arrival) and average the delay
#have selection for all or only late, dep/arriv side-by-side
#also continuous color scale (?) so not just size (maybe)
