# Cargar datos desde planillas (en este caso csv)
Resumen_UnidadFiscalizable <- read_csv("../Datos/Resumen_UnidadFiscalizable.csv")

Detalle_UnidadFiscalizableInstrumento <- read_csv("../Datos/Detalle_UnidadFiscalizableInstrumento.csv")

Datos_Instrumento <- Detalle_UnidadFiscalizableInstrumento %>% 
  left_join(
    select(Resumen_UnidadFiscalizable, UnidadFiscalizableId, CategoriaEconomicaNombre, RegionNombre)
  )

Resumen_ProcesoSancion <- 
  read_excel("../Datos/Resumen_ProcesoSancion.xlsx") %>% 
  select(ProcesoSancionId, Expediente, ProcesoSancionTipoNombre, 
         ProcesoSancionEstadoNombre, FechaInicio, FechaTermino,
         ConfirmaPdC, MultaTotalUTA) %>% 
  mutate(AnoInicio = year(FechaInicio),
         AnoExpediente = as.integer(substr(Expediente, 7, 10)))

Detalle_ProcesoSancionUnidadFiscalizable <- 
  read_excel("../Datos/Detalle_ProcesoSancionUnidadFiscalizable.xlsx") %>% 
  select(ProcesoSancionId,  
         CategoriaEconomica = CategoriaEconomicaNombre, 
         SubCategoriaEconomica = SubCategoriaEconomicaNombre,
         Comuna = ComunaNombre,
         Region = RegionNombre)

Datos_Sancion <- 
  Resumen_ProcesoSancion %>% 
  left_join(Detalle_ProcesoSancionUnidadFiscalizable, by = "ProcesoSancionId") %>% 
  mutate(RegionSelect = case_when(
    Region == reg ~ reg,
    TRUE ~ "Resto de las Regiones"))
