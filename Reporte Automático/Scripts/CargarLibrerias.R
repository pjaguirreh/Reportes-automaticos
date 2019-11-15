lista_paquetes <- c("dplyr", "ggplot2", "lubridate", "tidyr", "kableExtra",
                    "purrr", "readr", "extrafont", "stringr", "ggmap", "readxl"); nuevos_paquetes <- lista_paquetes[!(lista_paquetes %in% installed.packages()[,"Package"])]
                    lapply(nuevos_paquetes, install.packages); lapply(lista_paquetes, require, character.only = TRUE); rm(lista_paquetes, nuevos_paquetes)
                    
loadfonts()