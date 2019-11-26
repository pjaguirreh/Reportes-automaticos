setwd("C:/Users/pjagu/OneDrive/Documents/GitHub/Reportes-automaticos/Ejemplo Script RStudio")

# Cargar librerías
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggrepel)
library(readr)

# Cargar planilla "maestra" con los datos de interés
data <- 
  # Cargar planilla de datos (.csv)
  read_csv("Datos/WDIData.csv") 

# Cargar planilla complementaria
paises <- read_csv("Datos/WDICountry.csv") %>% 
  # Dejar solo países y no regiones (por ej, Latin America)
  filter(!is.na(`Income Group`)) 

# Manejo de datos
datos <- data %>% 
  # Seleccionar algunos indicadores
  filter(`Indicator Name` %in% c("Government expenditure on education, total (% of GDP)",
                                 "GINI index (World Bank estimate)",
                                 "Unemployment, total (% of total labor force) (modeled ILO estimate)",
                                 "Research and development expenditure (% of GDP)",
                                 "Military expenditure (% of GDP)",
                                 "GDP per capita, PPP (current international $)"
  )) %>% 
  
  # Dejar solo observaciones que corresponden a países y no a regiones (por ej, Latin America)
  filter(`Country Name` %in% paises$`Table Name`) %>% 
  
  # Cambiar la forma de los datos de "ancho" a "largo"
  pivot_longer("2012":"2018", names_to = "Year", values_to = "Value") %>% 
  
  # Imputación: rellenar valores NA de indicadores cuando se pueda
  group_by(`Country Name`, `Indicator Name`) %>% 
  fill(Value, .direction = "downup") %>% 
  ungroup() %>% 
  
  # Agregar columna con información sobre nivel de ingresos y regiónde cada país
  left_join(select(paises, `Table Name`, `Income Group`, Region), by = c("Country Name" = "Table Name")) %>% 
  
  # Sacar columnas que no serán utilizadas
  select(-`Indicator Code`, -`Country Code`) %>% 
  
  # Cambiar nombres de variables a español
  rename("pais" = "Country Name",
         "indicador" = "Indicator Name",
         "anio" = "Year",
         "valor" = "Value",
         "grupo_ingresos" = "Income Group",
         "region" = "Region") %>% 
  
  # Cambiar nombres de "indicador", region, y grupo de ingresos a español
  mutate(indicador = recode(indicador,
                            "GDP per capita, PPP (current international $)" = "pib_percapita",
                            "GINI index (World Bank estimate)" = "gini",
                            "Government expenditure on education, total (% of GDP)" = "gasto_educacion",
                            "Military expenditure (% of GDP)"  = "gasto_militar",
                            "Research and development expenditure (% of GDP)" = "gasto_I&D",
                            "Unemployment, total (% of total labor force) (modeled ILO estimate)" = "desempleo",
  ),
  region = recode(region,
                  "South Asia" = "Asia del Sur",
                  "Europe & Central Asia" = "Europa & Asia Central",
                  "Middle East & North Africa" = "Medio Este & Africa del Norte",
                  "East Asia & Pacific" = "Asia del Este & Pacífico",
                  "Sub-Saharan Africa" = "Africa Subsahariana",
                  "Latin America & Caribbean" = "Latinoamérica y el Caribe",
                  "North America" = "América del Norte"
  ),
  grupo_ingresos = recode(grupo_ingresos,
                          "Low income" = "Ingreso Bajo",
                          "Lower middle income" = "Ingreso Medio-Bajo",
                          "Upper middle income" = "Ingreso Medio-Alto",
                          "High income" = "Ingreso Alto"
  ),
  OECD = ifelse(pais %in% c("Australia", "Austria", "Belgium", "Canada", "Chile", "Czech Republic",
                     "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary",
                     "Iceland", "Ireland", "Israel", "Italy", "Japan", "Latvia", "Lithuania",
                     "Luxembourg", "Mexico", "Netherlands", "New Zealand", "Norway", "Poland",
                     "Portugal", "Slovenia", "Spain", "Sweden", "Switzerland", "Turkey",
                     "United Kingdom", "United States"), "Si", "No")
  ) %>% 
  
  # Cambiar tipo de variables de "character" a "factor"
  mutate(
    pais = as.factor(pais),
    anio = as.factor(anio),
    grupo_ingresos = as.factor(grupo_ingresos)
  ) %>% 
  
  # Transformar los valores de la columna "indicador" a sus propias columnas
  pivot_wider(names_from = indicador, values_from = valor)

# El gráfico solo se enfocará en el año 2018
datos_graf <- datos %>% 
  filter(anio == 2018) 

# Gráfico
datos_graf %>% 
  ggplot(aes(x = gasto_educacion, y = gasto_militar, label = pais)) +
  geom_abline(aes(intercept = 0, slope = 1), linetype = "dashed") +
  geom_point(aes(color = region), size = 2) +
  geom_label_repel(data = datos_graf %>% filter(pais %in% c("Chile", "United States", "Israel") |
                                                gasto_militar> 7.5),
                  fontface = 'bold',
                  box.padding = unit(0.5, "lines"),
                  point.padding = unit(0.5, "lines"),
                  segment.color = 'grey50') +
  xlim(0,8) +
  ylim(0, 10) +
  theme_bw() +
  labs(y = "Gasto Militar (% del PIB)",
       x = "Gasto en Educación (% del PIB)",
       title = "Relación entre Gasto Militar y Gasto en Educación (2018)",
       subtitle = "La gran parte de los países del mundo gasta más en educación")
