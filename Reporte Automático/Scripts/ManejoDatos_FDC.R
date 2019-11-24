# Datos: FdC por región

FDC_reg_porcentaje <- Datos_Sancion %>% 
  distinct(ProcesoSancionId, Region, AnoInicio, AnoExpediente) %>% 
  group_by(Region) %>% 
  summarise(FDC = n()) %>%
  replace_na(list(Region = "Sin Región")) %>% 
  arrange(desc(FDC)) %>% 
  mutate(Porcentaje = round(FDC/sum(FDC)*100,1),
         Destacar = case_when(Region == reg ~ "Si",
                              TRUE ~ "No"),
         orden_reg = case_when(
           Region == "Región de Arica y Parinacota" ~ 16,
           Region == "Región de Tarapacá" ~ 15,
           Region == "Región de Antofagasta" ~ 14,
           Region == "Región de Atacama" ~ 13,
           Region == "Región de Coquimbo" ~ 12,
           Region == "Región Metropolitana" ~ 11,
           Region == "Región de Valparaíso" ~ 10,
           Region == "Región del Libertador General Bernardo O'Higgins" ~ 9,
           Region == "Región del Maule" ~ 8,
           Region == "Región de Ñuble" ~ 7,
           Region == "Región del Biobío" ~ 6,
           Region == "Región de la Araucanía" ~ 5,
           Region == "Región de Los Ríos" ~ 4,
           Region == "Región de los Lagos" ~ 3,
           Region == "Región de Aysén del General Carlos Ibañez del Campo" ~ 2,
           Region == "Región de Magallanes y la Antártica Chilena" ~ 1
         ),
         rank = 1:n())

# Datos: FdC por año

FDC_año <- Datos_Sancion %>% 
  distinct(ProcesoSancionId, RegionSelect, AnoInicio, AnoExpediente) %>% 
  group_by(AnoExpediente, RegionSelect) %>% 
  summarise(FDC = (n())) %>% 
  arrange(AnoExpediente)

# Datos: FdC categoría

Comparar <- FDC_año %>% 
  ungroup() %>% group_by(RegionSelect) %>% 
  summarise(sum(FDC))

FDC_cate <- Datos_Sancion %>% 
  distinct(ProcesoSancionId, CategoriaEconomica, AnoInicio, AnoExpediente, RegionSelect) %>% 
  group_by(CategoriaEconomica, RegionSelect) %>% 
  summarise(FDC = n()) %>% 
  ungroup() %>% 
  group_by(RegionSelect) %>% 
  mutate(Porcentaje = round(FDC/sum(FDC)*100,1),
         Destacar = case_when(is.na(CategoriaEconomica) ~ "Si",
                              TRUE ~ "No")) %>% 
  filter(RegionSelect == reg)

MAX_cate <- FDC_cate %>% filter(RegionSelect == reg) %>% 
  arrange(desc(FDC))

# Datos: FDC origen

FDC_origen <- Datos_Sancion %>% 
  filter(Region == reg) %>% 
  distinct(ProcesoSancionId, ProcesoSancionTipoNombre) %>% 
  group_by(ProcesoSancionTipoNombre) %>% 
  summarise(FDC = n()) %>% 
  mutate(Porcentaje = round(FDC/sum(FDC)*100,0)) %>% 
  arrange(desc(FDC)) 

# Datos: FDC estado

FDC_estado <- Datos_Sancion %>% 
  distinct(ProcesoSancionId, Region, AnoInicio, AnoExpediente, ProcesoSancionEstadoNombre) %>% 
  filter(Region == reg) %>% 
  mutate(Estado = case_when(
    ProcesoSancionEstadoNombre %in% c("Terminado - PDC", "PDC Ejecutado", "PDC en Análisis", "PDC en Ejecución") ~ "En PDC",
    ProcesoSancionEstadoNombre %in% c("Terminado - Absolución", "Terminado - Archivado", "Terminado - Sanción") ~ "Terminado",
    TRUE ~ "En proceso" 
  )) %>% 
  group_by(Estado) %>% 
  summarise(FDC = n()) %>% 
  mutate(Porcentaje = round(FDC/sum(FDC)*100,1)) 

FDC_estado_detalle <- Datos_Sancion %>% 
  distinct(ProcesoSancionId, Region, AnoInicio, AnoExpediente, ProcesoSancionEstadoNombre) %>% 
  filter(Region == reg)

