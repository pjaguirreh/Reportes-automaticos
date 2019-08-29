imprimir_reporte <- function(region) {
  rmarkdown::render(
    "Reporte Automático/ReportePorRegion.Rmd", 
    params = list(
      reg = region
    ),
    encoding = "UTF-8",
    output_file = paste0("Reporte_", region, "_", format(Sys.Date(), "%d%m%Y"), ".docx")
  )
  filesstrings::file.move(paste0("Reporte Automático/Reporte_", region, "_", format(Sys.Date(), "%d%m%Y"), ".docx"), 
                          "Reporte Automático/Reportes por región/")
}

#imprimir_reporte("Araucanía")

#Opciones
regiones <- c("Tarapacá"
              , "Antofagasta"
              , "Atacama"
              , "Coquimbo"
              , "O'Higgins"
              , "Valparaíso"
              , "Maule"
              , "Biobío"
              , "Araucanía"
              , "Lagos"
              , "Aysén"
              , "Magallanes"
              , "Metropolitana"
              , "Ríos"
              , "Arica"
              , "Ñuble")

for (i in regiones){
  imprimir_reporte(i)
}



