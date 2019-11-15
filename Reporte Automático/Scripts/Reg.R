reg1 <- c("Región de Tarapacá"
          , "Región de Antofagasta"
          , "Región de Atacama"
          , "Región de Coquimbo"
          , "Región del Libertador General Bernardo O'Higgins"
          , "Región de Valparaíso"
          , "Región del Maule"
          , "Región del Biobío"
          , "Región de la Araucanía"
          , "Región de los Lagos"
          , "Región de Aysén del General Carlos Ibañez del Campo"
          , "Región de Magallanes y la Antártica Chilena"
          , "Región Metropolitana"
          , "Región de Los Ríos"
          , "Región de Arica y Parinacota"
          , "Región de Ñuble")

reg2 <- c("Tarapacá"
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


reg3 <- as.data.frame(cbind(reg1,reg2))

reg <- as.character(reg3[reg3$reg2 == params$reg, 1]) #esto facilita la impresión desde "ImprimirReportes_Región.R"