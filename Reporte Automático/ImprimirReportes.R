# Valores que se usarán como "parámetros" (variables) del reporte
regiones <- c("Tarapacá", "Antofagasta", "Atacama", "Coquimbo", "O'Higgins", 
              "Valparaíso", "Maule", "Biobío", "Araucanía", "Lagos", "Aysén", 
              "Magallanes", "Metropolitana", "Ríos", "Arica", "Ñuble")

# Definir función para generación de reportes
for (i in regiones){
  rmarkdown::render("ReportePorRegion.Rmd",
                  params = list(reg = i),
                  output_file = paste0("Reportes/Reporte_", i, "_", format(Sys.Date(), "%d-%m-%Y"))
                  )
}


