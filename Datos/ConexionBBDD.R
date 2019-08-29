#Este es un archivo complementario a "2.Importar.Rmd" (este script se ejecuta desde ahí)
#Ambos archivos tienen que estar en la misma carpeta para que corra bien el código (si no hay que especificar bien la ruta)

# install.packages("DBI")
# install.packages("dplyr")
library(DBI)
library(dplyr)
library(readxl)

con <- dbConnect(RSQLite::SQLite(), dbname = ":memory:")

#https://cran.r-project.org/web/packages/dbplyr/vignettes/dbplyr.html

datos <- read_excel("../Datos/datos_obesidad_gdp.xlsx")

copy_to(con, c(Resumen_UnidadFiscalizable, Detalle_UnidadFiscalizableInstrumento), c("Resumen_UnidadFiscalizable", "Detalle_UnidadFiscalizableInstrumento"),
        temporary = FALSE
)
copy_to(con, Resumen_UnidadFiscalizable, "Resumen_UnidadFiscalizable",
        temporary = FALSE
)
copy_to(con, Detalle_UnidadFiscalizableInstrumento, "Detalle_UnidadFiscalizableInstrumento",
        temporary = FALSE
)

rm(datos)