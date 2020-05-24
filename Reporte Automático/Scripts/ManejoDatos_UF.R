# Datos: UF por región
UF_reg <- Resumen_UnidadFiscalizable %>% filter(RegionNombre == reg)

resumen_reg <- Resumen_UnidadFiscalizable %>% 
  group_by("Región" = RegionNombre) %>% 
  summarise(UFs = n()) %>% 
  arrange(desc(UFs)) %>% 
  ungroup() %>% 
  mutate(Porcentaje = round(UFs/sum(UFs)*100,1),
         Destacar = case_when(`Región` == reg ~ "Si",
                              is.na(`Región`) ~ "Si2",
                              TRUE ~ "No"),
         orden_reg = case_when(
           `Región` == "Región de Arica y Parinacota" ~ 17,
           `Región` == "Región de Tarapacá" ~ 16,
           `Región` == "Región de Antofagasta" ~ 15,
           `Región` == "Región de Atacama" ~ 14,
           `Región` == "Región de Coquimbo" ~ 13,
           `Región` == "Región Metropolitana" ~ 12,
           `Región` == "Región de Valparaíso" ~ 11,
           `Región` == "Región del Libertador General Bernardo O'Higgins" ~ 10,
           `Región` == "Región del Maule" ~ 9,
           `Región` == "Región de Ñuble" ~ 8,
           `Región` == "Región del Biobío" ~ 7,
           `Región` == "Región de la Araucanía" ~ 6,
           `Región` == "Región de Los Ríos" ~ 5,
           `Región` == "Región de los Lagos" ~ 4,
           `Región` == "Región de Aysén del General Carlos Ibañez del Campo" ~ 3,
           `Región` == "Región de Magallanes y la Antártica Chilena" ~ 2,
           is.na(`Región`) ~ 1
         ))

Porcentaje_uf_reg <- filter(resumen_reg, `Región` == reg)[[3]]

# Datos: UF por categoría

resumen_cate <- Resumen_UnidadFiscalizable %>% 
  filter(RegionNombre == reg) %>% 
  group_by("Categoría Económica" = CategoriaEconomicaNombre) %>% 
  summarise(UFs = n()) %>% 
  arrange(desc(UFs)) %>% 
  ungroup() %>% 
  mutate(Porcentaje = round(UFs/sum(UFs)*100,1),
         Destacar = case_when(is.na(`Categoría Económica`) ~ "Si",
                              TRUE ~ "No"))

# Datos: Top 5 Cat por RCA

top_RCA <- Datos_Instrumento %>% 
  filter(SiglaInstrumento == "RCA", #Instrumento de inter?s
         NombreRegion == reg #Filtro región
         #Existen RCAs "interregionales" que en "NombreRegionPoryecto" especifican región (acá se consideran)
         | (NombreRegion == "Interregional" & NombreRegionProyecto == reg)) %>% # | signfica "o"
  group_by(CategoriaEconomicaNombre) %>% 
  summarise(RCAs = n()) %>% 
  ungroup() %>% 
  rename("Categoría Económica" = CategoriaEconomicaNombre) %>% 
  arrange(desc(RCAs)) %>% 
  top_n(5) 
