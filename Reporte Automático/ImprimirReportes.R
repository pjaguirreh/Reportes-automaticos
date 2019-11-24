# Crear función de reporte
imprimir_reporte <- function(region) {
  # funcion para imprimir reportes
  rmarkdown::render(
    "ReportePorRegion.Rmd", 
    params = list(
      # este es el parametro que se pasará a cada documento (nombre de región)
      reg = region
    ),
    encoding = "UTF-8",
    # Nombre que tendrá el documento final
    output_file = paste0("Reporte_", region, "_", format(Sys.Date(), "%d%m%Y"), ".docx")
  )
  # Tomar el reporte creado y moverlo a la carpeta "Reportes por región"
  filesstrings::file.move(paste0("Reporte_", region, "_", format(Sys.Date(), "%d%m%Y"), ".docx"), 
                          "Reportes por región/")
}

#imprimir_reporte("Araucanía")

# Crear un vector con todas las regiones
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

# Realizar un loop donde se imprimirá un reporte para cada región
for (i in regiones){
  imprimir_reporte(i)
}



