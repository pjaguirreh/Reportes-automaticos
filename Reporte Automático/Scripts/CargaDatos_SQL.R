library(DBI)
library(odbc)

# Conectar a SQL
con <- dbConnect(odbc::odbc(),
                 encoding = "windows-1252",
                 .connection_string = "Driver={SQL Server};Server=LAPTOP-PRIBIMSU\\SQLEXPRESS;Database=master;trusted_connection=yes")

# Cargar datos desde (4) planillas en SQL

Resumen_UnidadFiscalizable <- dbGetQuery(con, "SELECT * FROM master..Resumen_UnidadFiscalizable")

Datos_Instrumento <- dbGetQuery(con, "SELECT * FROM master..Datos_Instrumento")

Detalle_ProcesoSancionUnidadFiscalizable <- dbGetQuery(con, "SELECT * FROM master..Detalle_ProcesoSAncionUnidadFiscalizable")

Datos_Sancion <- dbGetQuery(con, "SELECT * FROM master..Datos_Sancion")

Datos_Sancion <- Datos_Sancion %>% 
  mutate(RegionSelect = case_when(
    Region == reg ~ reg,
    TRUE ~ "Resto de las Regiones"))
