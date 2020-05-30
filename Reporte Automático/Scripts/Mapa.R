centroides <- tribble(
  ~Region,	~latitud,	~longitud,
  "Región de Arica y Parinacota",	-18.496932,	-69.62854,
  "Región de Tarapacá",	-20.215794,	-69.393066,
  "Región de Antofagasta",	-23.53599,	-69.119139,
  "Región de Atacama",	-27.395285,	-69.910141,
  "Región de Coquimbo",	-30.619033,	-70.860692,
  "Región de Valparaíso",	-32.782424,	-70.959617,
  "Región Metropolitana",	-33.604344,	-70.627063,
  "Región del Libertador General Bernardo O'Higgins",	-34.435366,	-71.046566,
  "Región del Maule",	-35.62133,	-71.445649,
  "Región de Ñuble",	-36.645411,	-71.974643,
  "Región del Biobío",	-37.500562,	-72.392417,
  "Región de la Araucanía",	-38.649155,	-72.27425,
  "Región de Los Ríos",	-40.004982,	-72.570862,
  "Región de los Lagos",	-42.04281,	-72.89418,
  "Región de Aysén del General Carlos Ibáñez del Campo",	-46.416524,	-73.257083,
  "Región de Magallanes y la Antártica Chilena",	-52.488319,	-71.873603
)

coord_uf <- Resumen_UnidadFiscalizable %>%
  select("RegionNombre", "Latitud", "Longitud") %>%
  filter(RegionNombre == reg, !is.na(Latitud), !is.na(Longitud))

if (reg == "Región de Aysén del General Carlos Ibáñez del Campo"){
  long <- unique(coord_uf$Longitud_reg)
  ltd <- unique(coord_uf$Latitud_reg)
} else {
  long <- filter(centroides, Region == reg)$longitud
  ltd <- filter(centroides, Region == reg)$latitud
}

if (reg %in% c("Región de Antofagasta", "Región de Atacama", "Región de Coquimbo", "Región de los Lagos",
               "Región de Aysén del General Carlos Ibáñez del Campo", "Región de Magallanes y la Antártica Chilena")){
  z <- 7
} else {
  z <- 8
}

m <- leaflet(coord_uf) %>% 
  setView(lng = long, lat = ltd, zoom = z) %>% 
  addProviderTiles(providers$CartoDB.Positron) %>% 
  addCircleMarkers(~Longitud, ~Latitud, color = "red", weight = 1, radius = 3)

mapshot(m, file = "~/mapa.png")

file.move("~/mapa.png", "Mapa/", overwrite = TRUE)
