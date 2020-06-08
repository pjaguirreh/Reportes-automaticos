library(purrr)

# Definir función para generación de reportes
imprimir_reporte <- function(x){
  rmarkdown::render("ReportePorRegion.Rmd",
                  params = list(reg = x),
                  output_file = paste0("Reportes/Reporte_", x, "_", format(Sys.Date(), "%d-%m-%Y"))
                  )
}

# Valores que se usarán como "parámetros" (variables) del reporte
regiones <- c("Tarapacá", "Antofagasta", "Atacama", "Coquimbo", "O'Higgins", 
              "Valparaíso", "Maule", "Biobío", "Araucanía", "Lagos", "Aysén", 
              "Magallanes", "Metropolitana", "Ríos", "Arica", "Ñuble")

# Aplicar la función a cada valor de "regiones"
walk(regiones, imprimir_reporte)

