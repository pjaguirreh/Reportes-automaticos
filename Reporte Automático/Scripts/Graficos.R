# UFs por región

uf_reg <- resumen_reg %>% 
  ggplot(aes(reorder(`Región`, orden_reg), Porcentaje, label = paste0(prettyNum(Porcentaje, big.mark = ".", decimal.mark = ","),"%", " (", prettyNum(UFs, big.mark = ".", decimal.mark = ","),")"), fill = Destacar)) + 
  geom_col() +
  ylim(0, max(resumen_cate$Porcentaje)*1.22) + 
  coord_flip() +
  geom_text(hjust = -0.22, size = 3) +
  scale_fill_manual(values = c("Si" = "#E87474", "No" = "light blue", "Si2" = "light gray")) + 
  theme(panel.background = element_rect(fill = NA),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),
        text = element_text(family = "Calibri")
  )

# UFs por categoría económica

uf_cat <- resumen_cate %>% 
  ggplot(aes(reorder(`Categoría Económica`, Porcentaje), Porcentaje, label = paste0(prettyNum(Porcentaje, big.mark = ".", decimal.mark = ","),"%", " (", prettyNum(UFs, big.mark = ".", decimal.mark = ","), ")"), fill = Destacar)) + 
  geom_col() +
  ylim(0, max(resumen_cate$Porcentaje)*1.2) + 
  coord_flip() +
  geom_text(hjust = -0.05, size = 3) +
  scale_fill_manual(values = c("Si" = "light gray", "No" = "light blue")) + 
  theme(panel.background = element_rect(fill = NA),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),
        text = element_text(family = "Calibri")
  )

# FDC region

fdc_reg <- FDC_reg_porcentaje %>%
  ggplot(aes(reorder(Region, orden_reg), Porcentaje, label = paste0(prettyNum(Porcentaje, big.mark = ".", decimal.mark = ","), "%", " (", prettyNum(FDC, big.mark = ".", decimal.mark = ","), ")"), fill = Destacar)) + 
  geom_col() +
  ylim(0, max(FDC_reg_porcentaje$Porcentaje)*1.25) + 
  coord_flip() +
  geom_text(hjust = -0.22, size = 3) +
  scale_fill_manual(values = c("Si" = "#E87474", "No" = "light blue", "Si2" = "light gray")) + 
  theme(panel.background = element_rect(fill = NA),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),
        text = element_text(family = "Calibri")
  )

# FDC Año

fdc_anio <- FDC_año %>%
  filter(RegionSelect == reg) %>% 
  ggplot(aes(AnoExpediente, FDC, label = FDC)) +
  geom_line(color = "light blue", size = 2)  +
  geom_label(color = "#E87474")  +
  ylim(min(FDC_año[FDC_año$RegionSelect == reg,]$FDC)-2, max(FDC_año[FDC_año$RegionSelect == reg,]$FDC)*1.05) + 
  scale_x_continuous(breaks = c(2012:2019)) +
  labs(y = "FDC") +
  theme(panel.background = element_rect(fill = NA),
        legend.position = "top",
        legend.title = element_blank(),
        legend.key = element_rect(size = 1),
        legend.key.size = unit(0.5, 'lines'),
        plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        text = element_text(family = "Calibri")
  )

# FDC categoria

fdc_cat <- FDC_cate %>% 
  ggplot(aes(reorder(CategoriaEconomica, Porcentaje), Porcentaje, label = paste0(prettyNum(Porcentaje, big.mark = ".", decimal.mark = ","), "%", " (", prettyNum(FDC, big.mark = ".", decimal.mark = ","), ")"), fill = Destacar)) + 
  geom_col() +
  ylim(0, max(FDC_cate$Porcentaje)*1.2) + 
  coord_flip() +
  geom_text(hjust = -0.22, size = 3) +
  scale_fill_manual(values = c("Si" = "light gray", "No" = "light blue")) + 
  theme(panel.background = element_rect(fill = NA),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_blank(),
        text = element_text(family = "Calibri")
  )

# FDC Origen

fdc_origen <- FDC_origen %>% 
  ggplot(aes(ProcesoSancionTipoNombre, Porcentaje, label = paste0(Porcentaje, "%", " (", FDC, ")"))) + 
  geom_col(fill = "light blue", width = 0.6) +
  ylim(0, max(FDC_origen$Porcentaje)*1.05) + 
  geom_text(vjust = -0.5, size = 3) +
  labs(y = "Porcentaje (%)") +
  theme(panel.background = element_rect(fill = NA),
        legend.position = "top",
        legend.title = element_blank(),
        legend.key = element_rect(size = 1),
        legend.key.size = unit(0.5, 'lines'),
        plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(margin = margin(t = -5)),
        text = element_text(family = "Calibri")
  )

# FDC Estado

fdc_estado <- FDC_estado %>% 
  ggplot(aes(Estado, Porcentaje, label = paste0(Porcentaje, "%", " (", FDC, ")"))) + 
  geom_col(fill = "light blue", width = 0.6) +
  ylim(0, max(FDC_estado$Porcentaje)*1.05) + 
  geom_text(vjust = -0.5, size = 3) +
  labs(y = "Porcentaje (%)") +
  theme(panel.background = element_rect(fill = NA),
        legend.position = "top",
        legend.title = element_blank(),
        legend.key = element_rect(size = 1),
        legend.key.size = unit(0.5, 'lines'),
        plot.title = element_text(hjust = 0.5),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_text(margin = margin(t = -5)),
        text = element_text(family = "Calibri")
  )