coord_uf <- Resumen_UnidadFiscalizable %>%
  select("RegionNombre", "Latitud", "Longitud") %>%
  filter(RegionNombre == reg, !is.na(Latitud), !is.na(Longitud))

register_google("AIzaSyCpuZ39bjnsBYVy72SMQsdXXngvjYaaVqc")

# obteniendo mapa
mapa <- get_map(location <- c(lon = mean(coord_uf$Longitud), lat = mean(coord_uf$Latitud)), 
                zoom = ifelse(reg %in% c("Región de Antofagasta", "Región de Aysén del General Carlos Ibañez del Campo", "Región de Magallanes y la Antártica Chilena", "Región de Atacama"), 7, 8),
                maptype = "roadmap", scale = 4, crop = FALSE, colo = "bw")

# ploteando mapa
mapa <- ggmap(mapa) +
  geom_point(data = coord_uf, aes(x = Longitud, y = Latitud, fill = "red", alpha = 0.8), size = 2, shape = 21) +
  guides(fill = FALSE, alpha = FALSE, size = FALSE) 
