library(osmdata)
library(tidyverse)
library(df) ##require(df)

tubi <- getbb("Tubingen, Germany")
tubi
streets <- tubi%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()


  small_streets <- tubi%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway")) %>%
  osmdata_sf()

river <- tubi%>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()

ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .8) +
  coord_sf(xlim = c(8.96, 9.12), 
           ylim = c(48.45, 48.59),
           expand = FALSE)

ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ff7f8e",          size = .3,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#91e386",          size = .2,
          alpha = .6) +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "#7b79fc",          size = .5,
          alpha = .5) +
  coord_sf(xlim = c(9.02, 9.08), 
           ylim = c(48.50, 48.54),
           expand = FALSE) +
  #coord_sf(xlim = c(8.96, 9.12), 
           #ylim = c(48.45, 48.59),
           #expand = FALSE) +
  theme_void() +
  theme(    plot.background = element_rect(fill = "#282828")  )


ggsave("maptuebingen.pdf", width = 5, height = 5)


