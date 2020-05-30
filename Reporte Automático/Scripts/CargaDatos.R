# Cargar datos desde (4) planillas 

Resumen_UnidadFiscalizable <- read_excel("../Datos/Resumen_UnidadFiscalizable.xlsx")

Datos_Instrumento <- read_excel("../Datos/Datos_Instrumento.xlsx")

Detalle_ProcesoSancionUnidadFiscalizable <- read_excel("../Datos/Detalle_ProcesoSancionUnidadFiscalizable.xlsx")

Datos_Sancion <- read_excel("../Datos/Datos_Sancion.xlsx") 

Datos_Sancion <- Datos_Sancion %>% 
  mutate(RegionSelect = case_when(
    Region == reg ~ reg,
    TRUE ~ "Resto de las Regiones"))
