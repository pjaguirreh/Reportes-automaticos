# Paquetes a usar
lista_paquetes <- c("dplyr", "ggplot2", "lubridate", "tidyr", "kableExtra", "flextable", "filesstrings",
                    "purrr", "readr", "extrafont", "stringr", "ggmap", "readxl", "leaflet", "mapview", "purrr")

# Revisar si paquetes están instalados. Si lo están, cargará los paquetes. Si no lo están, instalará y luego cargará los paquetes.
nuevos_paquetes <- lista_paquetes[!(lista_paquetes %in% installed.packages()[,"Package"])]
                    lapply(nuevos_paquetes, install.packages); lapply(lista_paquetes, require, character.only = TRUE)
                    
rm(lista_paquetes, nuevos_paquetes)
loadfonts()
