getbb("Sevilla, Spain")
sevilla <- getbb("Seville, Spain")
sevilla
streets <- sevilla%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()

small_streets <- sevilla%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway")) %>%
  osmdata_sf()

river <- sevilla%>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()


ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .6) +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .2,
          alpha = .5) +
  coord_sf(xlim = c(-6.05, -5.81), 
           ylim = c(37.30, 37.45),
          expand = TRUE)

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
  coord_sf(xlim = c(-6.05, -5.81), 
           ylim = c(37.30, 37.45),
           expand = FALSE) +
  theme_void() +
  theme(    plot.background = element_rect(fill = "#282828")  )

ggsave("mapseville.pdf", width = 6, height = 6)
