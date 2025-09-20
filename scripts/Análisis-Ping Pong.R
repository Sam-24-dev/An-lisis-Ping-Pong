#Instalacion de paquetes
install.packages(c("ggplot2", "dplyr", "psych", "readxl"))
install.packages("knitr")
install.packages("e1071")
install.packages("ggplot")

# Cargar el paquete
library(e1071)
library(ggplot2)
library(dplyr)
library(e1071)  
library(ggplot2)
library(readxl)
file.choose()

#Cargar los datos

PinPong= read.csv("C:\\Users\\samir\\OneDrive\\Documentos\\Datos\\Datos del experimento de Estadística.csv")

#Renombrar las columnas
colnames(PinPong) <- c("NA","Datos", "Intentos", "ManoDominante", "AlturaSaque", "TiempoSaque")

# Eliminar la columna 'NA' (si no es útil)
PinPong <- PinPong[ , -1]  # Esto elimina la primera columna que tiene el nombre "NA"




#Graficos

# Tabla de frecuencias para ManoDominante
frecuencia_mano <- PinPong %>%
  group_by(ManoDominante) %>%
  summarise(Frecuencia = n())

# Agregar fila con el total a la tabla de ManoDominante
frecuencia_mano_total <- frecuencia_mano %>%
  bind_rows(summarise(frecuencia_mano, ManoDominante = "Total", Frecuencia = sum(Frecuencia)))

print(frecuencia_mano_total)

# Tabla de frecuencias para AlturaSaque
frecuencia_altura <- PinPong %>%
  group_by(AlturaSaque) %>%
  summarise(Frecuencia = n())
print(frecuencia_altura_total)

# Agregar fila con el total a la tabla de AlturaSaque
frecuencia_altura_total <- frecuencia_altura %>%
  bind_rows(summarise(frecuencia_altura, AlturaSaque = "Total", Frecuencia = sum(Frecuencia)))

print(frecuencia_altura_total)

# Diagrama de barras para ManoDominante
ggplot(frecuencia_mano, aes(x = ManoDominante, y = Frecuencia, fill = ManoDominante)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Frecuencia de Manos Dominantes",  # Título del gráfico
    x = "Mano Dominante",                     # Etiqueta del eje X
    y = "Frecuencia Absoluta"                 # Etiqueta del eje Y
  ) +
  theme_minimal() +
  scale_fill_manual(values = c("darkred", "goldenrod4", "darkseagreen"))

# Diagrama de barras para AlturaSaque
ggplot(frecuencia_altura, aes(x = AlturaSaque, y = Frecuencia, fill = AlturaSaque)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Frecuencia de Altura de Saque",  # Título del gráfico
    x = "Altura de Saque",                    # Etiqueta del eje X
    y = "Frecuencia Absoluta"                 # Etiqueta del eje Y
  ) +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "orange", "purple"))


# Reemplazar las comas por puntos en la columna TiempoSaque
PinPong$TiempoSaque <- gsub(",", ".", PinPong$TiempoSaque)

# Convertir nuevamente a numérico
PinPong$TiempoSaque <- as.numeric(PinPong$TiempoSaque)

# Revisar si hay NA después de la conversión
sum(is.na(PinPong$TiempoSaque))
# Verificar los primeros valores de TiempoSaque
head(PinPong$TiempoSaque)
# Crear los intervalos para TiempoSaque desde 1.24 hasta 3
PinPong$Intervalo <- cut(PinPong$TiempoSaque, 
                         breaks = seq(1.24, 3, by = 0.1),  # Cambié el inicio a 1.24
                         include.lowest = TRUE, 
                         right = FALSE,  # Intervalo cerrado a la izquierda
                         labels = paste(seq(1.24, 2.9, by = 0.1), "-", seq(1.34, 3, by = 0.1)))

# Verificar los intervalos creados
table(PinPong$Intervalo)


# Tabla de frecuencias para TiempoSaque con intervalos
frecuencia_tiempo_intervalos <- PinPong %>%
  group_by(Intervalo) %>%
  summarise(Frecuencia = n())

# Mostrar la tabla
print(frecuencia_tiempo_intervalos)



# Histograma con ggplot2
library(ggplot2)

ggplot(PinPong, aes(x = TiempoSaque)) +
  geom_histogram(binwidth = 0.1, fill = "lightblue", color = "black", alpha = 0.7) +
  labs(
    title = "Distribución de Tiempo de Saque",   # Título del gráfico
    x = "Tiempo de Saque (segundos)",            # Etiqueta del eje X
    y = "Frecuencia"                            # Etiqueta del eje Y
  ) +
  theme_minimal()


# Diagrama de barras para la variable TiempoSaque 
ggplot(frecuencia_tiempo_intervalos, aes(x = Intervalo, y = Frecuencia, fill = as.factor(Intervalo))) +
  geom_bar(stat = "identity") +
  labs(
    title = "Frecuencia de Tiempo de Saque",  # Título del gráfico
    x = "Intervalos de Tiempo de Saque (segundos)",        # Etiqueta del eje X más clara
    y = "Frecuencia Absoluta"                # Etiqueta del eje Y
  ) +
  theme_minimal() +
  scale_fill_viridis_d(name = "Intervalos de Tiempo",  # Nombre más claro para la leyenda
                       labels = levels(frecuencia_tiempo_intervalos$Intervalo)) +  # Mostrar los rangos exactos 
  theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1))  # Aumentar tamaño y rotar los números en el eje X



# Diagrama de cajas horizontal para TiempoSaque
ggplot(PinPong, aes(x = TiempoSaque)) +
  geom_boxplot(fill = "lightblue", color = "black", outlier.colour = "red", outlier.shape = 8) +
  labs(
    title = "Diagrama de Cajas de Tiempo de Saque",  # Título del gráfico
    x = "Tiempo de Saque (segundos)",               # Etiqueta del eje X
    y = "Tiempo de Saque (segundos)"                # Etiqueta del eje Y
  ) +
  theme_minimal() +
  coord_flip()  # Esto invierte el gráfico para hacerlo horizontal


# Cargar el paquete necesario para la función skewness
library(e1071)

#Estadisticos descriptivos para la variable tiempo de saque 
# Medidas de tendencia central y dispersión
medidas <- PinPong %>%
  summarise(
    Media = mean(TiempoSaque, na.rm = TRUE),                # Media
    Desviacion_Estandar = sd(TiempoSaque, na.rm = TRUE),     # Desviación estándar
    Moda = as.numeric(names(sort(table(TiempoSaque), decreasing = TRUE)[1])),  # Moda
    Sesgo = skewness(TiempoSaque, na.rm = TRUE),             # Sesgo
    Minimo = min(TiempoSaque, na.rm = TRUE),                 # Mínimo
    Maximo = max(TiempoSaque, na.rm = TRUE),                 # Máximo
    Q1 = quantile(TiempoSaque, 0.25, na.rm = TRUE),          # Primer cuartil
    Mediana = median(TiempoSaque, na.rm = TRUE),             # Mediana
    Q3 = quantile(TiempoSaque, 0.75, na.rm = TRUE)           # Tercer cuartil
  )
print(medidas)

# Estadísticos descriptivos para Intentos
estadisticas_intentos <- PinPong %>%
  summarise(
    Media = mean(Intentos, na.rm = TRUE),                # Media
    Desviacion_Estandar = sd(Intentos, na.rm = TRUE),    # Desviación estándar
    Moda = as.numeric(names(sort(table(Intentos), decreasing = TRUE)[1])),  # Moda
    Sesgo = skewness(Intentos, na.rm = TRUE),            # Sesgo
    Minimo = min(Intentos, na.rm = TRUE),                # Mínimo
    Maximo = max(Intentos, na.rm = TRUE),                # Máximo
    Q1 = quantile(Intentos, 0.25, na.rm = TRUE),         # Primer cuartil
    Mediana = median(Intentos, na.rm = TRUE),            # Mediana
    Q3 = quantile(Intentos, 0.75, na.rm = TRUE)          # Tercer cuartil
  )

#Antes de hacer el histograma
frecuencias_15 <- table(cut(PinPong$Intentos, breaks=15))
tabla_frecuencias_15 <- as.data.frame(frecuencias_15)
print(tabla_frecuencias_15)


# Histograma de Frecuencia para la variable 'Intentos'
hist(PinPong$Intentos, 
     breaks=15,  # Puedes cambiar el número de intervalos (bins)
     main="Histograma de Intentos", 
     xlab="Número de Intentos", 
     ylab="Frecuencia", 
     col="lightblue", 
     border="black")


# Ajustar los márgenes y tamaño del gráfico
par(mar=c(5, 4, 4, 2))  # Márgenes (inferior, izquierda, superior, derecha)

# Diagrama de Caja (Boxplot) para la variable 'Intentos'
boxplot(PinPong$Intentos, 
        main="Diagrama de Caja de Intentos", 
        ylab="Número de Intentos", 
        col="lightgreen", 
        border="black")




#Analisis estadistico bivariado




#cORRELACION ENTRE INTENTOS VS TIEMPO DE SAQUE 
cor(PinPong$TiempoSaque, PinPong$Intentos, use = "complete.obs")

# 1. Gráfico de dispersión: Intentos vs Tiempo de Saque
ggplot(PinPong, aes(x = Intentos, y = TiempoSaque)) +
  geom_point(color = "blue", alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "red", size = 1.5) +  # Línea más gruesa
  labs(
    title = "Relación entre Intentos y Tiempo de Saque",
    x = "Intentos hasta el tercer éxito",
    y = "Tiempo de Saque (segundos)"
  ) +
  theme_minimal()







#Media y desviacion estandar  para cada categoria de altura 
PinPong %>%
  group_by(AlturaSaque) %>%
  summarise(
    Media = mean(TiempoSaque, na.rm = TRUE),
    SD = sd(TiempoSaque, na.rm = TRUE)
  )

# 2. Boxplot: Altura del Saque vs Tiempo de Saque
ggplot(PinPong, aes(x = AlturaSaque, y = TiempoSaque, fill = AlturaSaque)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, alpha = 0.7) +
  labs(
    title = "Tiempo de Saque según Altura del Saque",
    x = "Altura del Saque",
    y = "Tiempo de Saque (segundos)"
  ) +
  theme_minimal() +
  scale_fill_manual(values = c("blue", "orange", "purple"))




# 3. Tabla de contingencia: Mano Dominante vs Altura del Saque 
tabla_contingencia <- table(PinPong$AlturaSaque, PinPong$ManoDominante)
addmargins(tabla_contingencia)  # Agrega totales

# Gráfico de barras: Mano Dominante vs Altura del Saque
frecuencia_mano_altura <- PinPong %>%
  group_by(ManoDominante, AlturaSaque) %>%
  summarise(Frecuencia = n())

ggplot(frecuencia_mano_altura, aes(x = ManoDominante, y = Frecuencia, fill = AlturaSaque)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(
    title = "Relación entre Mano Dominante y Altura del Saque",
    x = "Mano Dominante",
    y = "Frecuencia Absoluta",
    fill = "Altura del Saque"
  ) +
  theme_minimal()

# Crear la tabla de contingencia
tabla_contingencia <- table(PinPong$ManoDominante, PinPong$AlturaSaque)

# Guardar la tabla como un archivo CSV
write.csv(tabla_contingencia, "tabla_contingencia.csv")

# Cargar la tabla desde el archivo CSV
tabla_contingencia <- read.csv("tabla_contingencia.csv")

# Mostrar la tabla en la consola
View(tabla_contingencia)
#Renombrar las columnas
colnames(tabla_contingencia) <- c("Mano Dominante","Abajo de la cintura ", "Arriba de la cintura ", "Arriba de los hombros")
View(tabla_contingencia)





#Grafico de barras con error estandar 
library(dplyr)
resumen <- PinPong %>%
  group_by(ManoDominante) %>%
  summarise(
    Media = mean(TiempoSaque, na.rm = TRUE),
    SD = sd(TiempoSaque, na.rm = TRUE),
    n = n()
  ) %>%
  mutate(Error = SD / sqrt(n))  # Error estándar
#Ver los datos para hacer una buena conclusion 
print(resumen)

ggplot(resumen, aes(x = ManoDominante, y = Media, fill = ManoDominante)) +
  geom_bar(stat = "identity", position = "dodge", width = 0.5) +  # Hacer las barras más estrechas
  geom_errorbar(aes(ymin = Media - Error, ymax = Media + Error), width = 0.3, size = 1) +  # Mejorar la visibilidad de las líneas de error
  labs(
    title = "Tiempo Promedio de Saque según Mano Dominante",
    x = "Mano Dominante",
    y = "Tiempo Promedio (segundos)"
  ) +
  theme_minimal() +
  scale_fill_manual(values = c("lightblue", "orange"))



#Estadistica inferencial
#Prueba de bondad de ajuste 
# 1. Estadísticas descriptivas para Intentos
estadisticas_descriptivas <- data.frame(
  Media = mean(PinPong$Intentos),
  Error_Estandar = sd(PinPong$Intentos)/sqrt(length(PinPong$Intentos)),
  Mediana = median(PinPong$Intentos),
  Moda = as.numeric(names(sort(table(PinPong$Intentos), decreasing = TRUE)[1])),
  Desviacion_Estandar = sd(PinPong$Intentos),
  Sesgo = skewness(PinPong$Intentos)
)

# 2. Ajustar distribución binomial negativa
k <- 3  # número de éxitos
p <- 0.3  # probabilidad de éxito

# Calcular frecuencias observadas
frec_observadas <- table(PinPong$Intentos)

# Calcular y normalizar probabilidades teóricas
x <- as.numeric(names(frec_observadas))
prob_teoricas <- dnbinom(x - k, size = k, prob = p)
prob_teoricas <- prob_teoricas / sum(prob_teoricas)

# Calcular frecuencias esperadas
frec_esperadas <- prob_teoricas * sum(frec_observadas)

# Identificar y agrupar categorías con frecuencias esperadas menores a 5
# Agrupar las primeras 15 categorías
frec_observadas_agrupadas <- c(
  sum(frec_observadas[1:15]),  # Sumar las primeras categorías
  sum(frec_observadas[16:length(frec_observadas)])  # Sumar las últimas categorías con frecuencias bajas
)

# Recalcular probabilidades teóricas para las categorías agrupadas
# Primero, vamos a seleccionar solo las primeras 15 categorías (las que tenemos para el agrupamiento)
prob_teoricas_agrupadas <- prob_teoricas[1:15]
prob_teoricas_agrupadas <- c(sum(prob_teoricas_agrupadas), sum(prob_teoricas[16:length(prob_teoricas)]))

# Calcular nuevas frecuencias esperadas para las categorías agrupadas
frec_esperadas_agrupadas <- prob_teoricas_agrupadas * sum(frec_observadas_agrupadas)

# Crear nueva tabla de frecuencias agrupadas
tabla_frecuencias_agrupadas <- data.frame(
  Intentos = c("1-15", "16+"),  # Nuevos índices para las categorías agrupadas
  Frec_Observada = frec_observadas_agrupadas,
  Frec_Esperada = round(frec_esperadas_agrupadas, 2)
)

# Realizar prueba chi-cuadrado con categorías agrupadas
prueba_chi_agrupada <- chisq.test(frec_observadas_agrupadas, p = prob_teoricas_agrupadas)

# Imprimir resultados
cat("\nEstadísticas Descriptivas para Intentos:\n")
print(round(estadisticas_descriptivas, 4))

cat("\nSupuestos de la prueba chi-cuadrado:\n")
cat("1. Observaciones independientes\n")
cat("2. Muestra aleatoria (n=309)\n")
cat("3. Frecuencias esperadas >= 5\n")

cat("\nResultados de la prueba chi-cuadrado:\n")
cat("Estadístico χ² =", round(prueba_chi_agrupada$statistic, 4), "\n")
cat("Grados de libertad:", prueba_chi_agrupada$parameter, "\n")
cat("Valor p:", format(prueba_chi_agrupada$p.value, scientific = FALSE), "\n")





#Pruebas de Hipótesis e Intervalos de Confianza
#1Prueba de hipotesis para una media

# Estadísticas descriptivas ya antes calculadas
media <- 1.945437
desviacion_estandar <- 0.3202813
moda <- 1.67
sesgo <- 0.5737873
minimo <- 1.24
maximo <- 2.91
Q1 <- 1.72
mediana <- 1.89
Q3 <- 2.14
n <- 309  # Tamaño de la muestra

# Supuestos de la hipótesis nula (Ejemplo: media = 2)
mu0 <- 2  # Cambia según el valor que quieras probar

# Error estándar de la media
error_estandar <- desviacion_estandar / sqrt(n)

# Estadístico de prueba Z (para muestras grandes)
estadistico_prueba <- (media - mu0) / error_estandar

# Valor p asociado al estadístico de prueba
valor_p <- 2 * (1 - pnorm(abs(estadistico_prueba)))

# Intervalo de confianza del 95%
z_alpha <- qnorm(0.975)  # Valor crítico para intervalo de confianza 95%
intervalo_inf <- media - z_alpha * error_estandar
intervalo_sup <- media + z_alpha * error_estandar

# Tabla de Estadísticas Descriptivas
estadisticas <- data.frame(
  "Estadística" = c("Media", "Error Estándar de la Media", "Desviación Estándar", "Moda", "Sesgo", "Mínimo", "Máximo", "Q1", "Mediana", "Q3"),
  "Valor" = c(media, error_estandar, desviacion_estandar, moda, sesgo, minimo, maximo, Q1, mediana, Q3)
)

# Tabla de Supuestos
supuestos <- data.frame(
  "Supuesto" = c("Tamaño de la muestra n >= 30", "Los datos son aproximadamente normales"),
  "Cumple" = c("Sí", "Sí")
)

# Tabla de Contraste de Hipótesis
contraste_hipotesis <- data.frame(
  "Hipótesis" = c("H0: μ = 2", "H1: μ ≠ 2"),
  "Descripción" = c("Media es igual a 2", "Media es diferente a 2")
)

# Tabla de Estadístico de Prueba
estadistico_prueba_tabla <- data.frame(
  "Fórmula" = c("Z = (x̄ - μ0) / (s / √n)"),
  "Valor de Z" = round(estadistico_prueba, 4)
)

# Tabla de Valor p
valor_p_tabla <- data.frame(
  "Valor p" = round(valor_p, 4)
)

# Tabla de Intervalo de Confianza
intervalo_confianza <- data.frame(
  "Fórmula" = c("Intervalo de Confianza 95%: x̄ ± Zα/2 * (s / √n)"),
  "Valor Inferior" = round(intervalo_inf, 4),
  "Valor Superior" = round(intervalo_sup, 4)
)



# Conclusión
if (valor_p < 0.05) {
  cat("\nRechazamos la hipótesis nula. Hay evidencia suficiente para afirmar que la media es diferente de", mu0, ".\n")
} else {
  cat("\nNo rechazamos la hipótesis nula. No hay evidencia suficiente para afirmar que la media es diferente de", mu0, ".\n")
}


#2Prueba de hipotesis para una proporcion 
# Frecuencias de las categorías
frecuencia_derecha <- 199
frecuencia_izquierda <- 110
total <- 309

# Proporciones observadas
proporcion_derecha <- frecuencia_derecha / total
proporcion_izquierda <- frecuencia_izquierda / total

# Proporción esperada bajo H0
p0 <- 0.6  # Proporción nula

# Cálculos del estadístico de prueba
error_estandar_p <- sqrt(p0 * (1 - p0) / total)
estadistico_prueba_p <- (proporcion_derecha - p0) / error_estandar_p

# Valor p para prueba bilateral
valor_p_p <- 2 * (1 - pnorm(abs(estadistico_prueba_p)))

# Intervalo de confianza del 95%
z_alpha <- qnorm(1 - 0.05 / 2)  # Valor crítico para nivel de confianza 95%
intervalo_inf_p <- proporcion_derecha - z_alpha * sqrt(proporcion_derecha * (1 - proporcion_derecha) / total)
intervalo_sup_p <- proporcion_derecha + z_alpha * sqrt(proporcion_derecha * (1 - proporcion_derecha) / total)

# Tabla de frecuencias y proporciones
tabla_frecuencias <- data.frame(
  "Mano Dominante" = c("Mano Derecha", "Mano Izquierda", "Total"),
  "Frecuencia" = c(frecuencia_derecha, frecuencia_izquierda, total),
  "Proporción" = c(round(proporcion_derecha, 4), round(proporcion_izquierda, 4), 1)
)

# Tabla de estadísticas descriptivas
estadisticas_proporcion <- data.frame(
  "Estadística" = c("Proporción Observada (Mano Derecha)", "Proporción Observada (Mano Izquierda)", "Error Estándar de la Proporción"),
  "Valor" = c(round(proporcion_derecha, 4), round(proporcion_izquierda, 4), round(error_estandar_p, 4))
)

# Tabla de supuestos
supuestos_proporcion <- data.frame(
  "Supuesto" = c("Tamaño de la muestra n >= 30", "np0 >= 5 y n(1-p0) >= 5"),
  "Cumple" = c("Sí", ifelse(total * p0 >= 5 & total * (1 - p0) >= 5, "Sí", "No"))
)

# Tabla de contraste de hipótesis
contraste_hipotesis_proporcion <- data.frame(
  "Hipótesis" = c(paste("H0: p =", p0), paste("H1: p ≠", p0)),
  "Descripción" = c(paste("La proporción es igual a", p0), paste("La proporción es diferente de", p0))
)

# Tabla de estadístico de prueba
estadistico_prueba_tabla_p <- data.frame(
  "Fórmula" = c("Z = (p̂ - p0) / √(p0(1-p0)/n)"),
  "Valor de Z" = round(estadistico_prueba_p, 4)
)

# Tabla de valor p
valor_p_tabla_p <- data.frame(
  "Valor p" = round(valor_p_p, 4)
)

# Tabla de intervalo de confianza
intervalo_confianza_p <- data.frame(
  "Fórmula" = c("p̂ ± Zα/2 * √(p̂(1-p̂)/n)"),
  "Valor Inferior" = round(intervalo_inf_p, 4),
  "Valor Superior" = round(intervalo_sup_p, 4)
)

# Conclusión
if (valor_p_p < 0.05) {
  cat(paste("\nRechazamos la hipótesis nula. Hay evidencia suficiente para afirmar que la proporción de Mano Derecha es diferente de", p0, ".\n"))
} else {
  cat(paste("\nNo rechazamos la hipótesis nula. No hay evidencia suficiente para afirmar que la proporción de Mano Derecha es diferente de", p0, ".\n"))
}



# 3 Prueba de Hipótesis para diferencias de medias
# 1. Crear el data frame asegurando que los datos sean consistentes
datosTvsM <- data.frame(
  Tiempo_Vuelo = as.numeric(as.character(PinPong$TiempoSaque)),  # Convertir a numérico
  ManoDominante = trimws(PinPong$ManoDominante)  # Eliminar espacios en Mano Dominante
)

# Revisar la estructura del data frame
cat("Estructura del data frame:\n")
str(datosTvsM)

# Diagnóstico inicial: valores NA
cat("\nCantidad de NA en 'Tiempo_Vuelo':", sum(is.na(datosTvsM$Tiempo_Vuelo)), "\n")
cat("Cantidad de NA en 'ManoDominante':", sum(is.na(datosTvsM$ManoDominante)), "\n")

# Filtrar datos válidos (remover NA)
datos_validos <- na.omit(datosTvsM)

# 2. Separar los datos por Mano Dominante
mano_derecha <- datos_validos[datos_validos$ManoDominante == "Mano Derecha", "Tiempo_Vuelo"]
mano_izquierda <- datos_validos[datos_validos$ManoDominante == "Mano Izquierda", "Tiempo_Vuelo"]

# Revisar el número de observaciones
cat("\nDatos disponibles:\n")
cat("Mano Derecha:", length(mano_derecha), "observaciones.\n")
cat("Mano Izquierda:", length(mano_izquierda), "observaciones.\n")

# Validación de tamaño para las pruebas
if (length(mano_derecha) >= 3 & length(mano_izquierda) >= 3) {
  
  # Pruebas de normalidad
  shapiro_derecha <- shapiro.test(mano_derecha)
  shapiro_izquierda <- shapiro.test(mano_izquierda)
  
  cat("\nResultados de las pruebas de normalidad:\n")
  cat("Mano Derecha: p =", shapiro_derecha$p.value, "\n")
  cat("Mano Izquierda: p =", shapiro_izquierda$p.value, "\n")
  
  # Prueba de igualdad de varianzas
  varianza_test <- var.test(mano_derecha, mano_izquierda)
  
  # Selección de prueba t
  if (varianza_test$p.value > 0.05) {
    prueba_t <- t.test(mano_derecha, mano_izquierda, var.equal = TRUE, alternative = "greater")
  } else {
    prueba_t <- t.test(mano_derecha, mano_izquierda, var.equal = FALSE, alternative = "greater")
  }
  
  # Resultados de la prueba t
  cat("\nPrueba t:\n")
  print(prueba_t)
  
} else {
  cat("\nNo hay suficientes datos para realizar las pruebas estadísticas.\n")
}



# Revisar los primeros valores de la columna TiempoSaque
head(PinPong$TiempoSaque, 20)

# Revisar valores únicos para identificar caracteres problemáticos
unique(PinPong$TiempoSaque)

# Detectar cuántos valores no numéricos existen
sum(!grepl("^-?\\d*(\\.\\d+)?$", PinPong$TiempoSaque))  # Identifica valores no numéricos




# Eliminar caracteres no numéricos
PinPong$TiempoSaque <- gsub("[^0-9.]", "", PinPong$TiempoSaque)  # Mantén solo números y puntos

# Convertir la columna a numérica
PinPong$TiempoSaque <- as.numeric(PinPong$TiempoSaque)

# Verificar cantidad de NAs después de la limpieza
cat("Cantidad de NA después de limpieza:", sum(is.na(PinPong$TiempoSaque)), "\n")



datosTvsM <- data.frame(
  Tiempo_Vuelo = PinPong$TiempoSaque,  # Ahora los datos están limpios
  ManoDominante = trimws(PinPong$ManoDominante)  # Asegúrate de eliminar espacios adicionales
)




# Revisar estructura y valores únicos
str(datosTvsM)
summary(datosTvsM)





# Estadísticas descriptivas
media_derecha <- mean(mano_derecha)
media_izquierda <- mean(mano_izquierda)
desviacion_derecha <- sd(mano_derecha)
desviacion_izquierda <- sd(mano_izquierda)

tabla_estadisticas <- data.frame(
  "Mano Dominante" = c("Mano Derecha", "Mano Izquierda"),
  "Frecuencia" = c(length(mano_derecha), length(mano_izquierda)),
  "Media" = c(round(media_derecha, 4), round(media_izquierda, 4)),
  "Desviación Estándar" = c(round(desviacion_derecha, 4), round(desviacion_izquierda, 4))
)

print(tabla_estadisticas)

# Conclusión
if (prueba_t$p.value < 0.05) {
  cat("\nConclusión: Rechazamos la hipótesis nula. La media de Mano Derecha es mayor que la de Mano Izquierda.\n")
} else {
  cat("\nConclusión: No rechazamos la hipótesis nula. No hay evidencia suficiente para afirmar que la media de Mano Derecha es mayor que la de Mano Izquierda.\n")
}












#4Prueba de Hipotesis para la diferencia de proporciones 
# Frecuencias de las categorías
frecuencia_arriba_hombros <- 107
frecuencia_arriba_cintura <- 142
total <- 309

# Proporciones observadas
proporcion_arriba_hombros <- frecuencia_arriba_hombros / total
proporcion_arriba_cintura <- frecuencia_arriba_cintura / total

# Proporción combinada
p_combinada <- (frecuencia_arriba_hombros + frecuencia_arriba_cintura) / total

# Cálculos del estadístico de prueba Z
error_estandar_z <- sqrt(p_combinada * (1 - p_combinada) * (1 / frecuencia_arriba_hombros + 1 / frecuencia_arriba_cintura))
estadistico_prueba_z <- (proporcion_arriba_hombros - proporcion_arriba_cintura) / error_estandar_z

# Valor p para prueba bilateral
valor_p_z <- 2 * (1 - pnorm(abs(estadistico_prueba_z)))

# Intervalo de confianza del 95%
z_alpha <- qnorm(1 - 0.05 / 2)  # Valor crítico para nivel de confianza 95%
intervalo_inf_z <- (proporcion_arriba_hombros - proporcion_arriba_cintura) - z_alpha * error_estandar_z
intervalo_sup_z <- (proporcion_arriba_hombros - proporcion_arriba_cintura) + z_alpha * error_estandar_z

# Tabla de frecuencias y proporciones
tabla_frecuencias_z <- data.frame(
  "Saque" = c("Arriba de los Hombros", "Arriba de la Cintura", "Total"),
  "Frecuencia" = c(frecuencia_arriba_hombros, frecuencia_arriba_cintura, total),
  "Proporción" = c(round(proporcion_arriba_hombros, 4), round(proporcion_arriba_cintura, 4), 1)
)

# Tabla de estadístico de prueba Z
estadistico_prueba_tabla_z <- data.frame(
  "Fórmula" = c("Z = (p̂1 - p̂2) / √(p̂(1 - p̂)(1/n1 + 1/n2))"),
  "Valor de Z" = round(estadistico_prueba_z, 4)
)

# Tabla de valor p
valor_p_tabla_z <- data.frame(
  "Valor p" = round(valor_p_z, 4)
)

# Tabla de intervalo de confianza
intervalo_confianza_z <- data.frame(
  "Fórmula" = c("p̂1 - p̂2 ± Zα/2 * √(p̂(1 - p̂)(1/n1 + 1/n2))"),
  "Valor Inferior" = round(intervalo_inf_z, 4),
  "Valor Superior" = round(intervalo_sup_z, 4)
)

# Tabla de supuestos
supuestos_proporcion <- data.frame(
  "Supuesto" = c("Tamaño de la muestra n >= 30", "np ≥ 5 y n(1 - p) ≥ 5"),
  "Cumple" = c("Sí", 
               ifelse(frecuencia_arriba_hombros * proporcion_arriba_hombros >= 5 & frecuencia_arriba_cintura * proporcion_arriba_cintura >= 5, 
                      "Sí", "No"))
)

# Conclusión
if (valor_p_z < 0.05) {
  cat(paste("\nRechazamos la hipótesis nula. La diferencia entre las proporciones de Saque Arriba de los Hombros y Saque Arriba de la Cintura es significativa.\n"))
} else {
  cat(paste("\nNo rechazamos la hipótesis nula. No hay evidencia suficiente para afirmar que la diferencia entre las proporciones de Saque Arriba de los Hombros y Saque Arriba de la Cintura es significativa.\n"))
}




#Analisis de Contingencia 
# Librería para manejo de tablas
library(knitr)

# Definir los datos proporcionados para las frecuencias
frecuencia_mano_total <- data.frame(
  ManoDominante = c("Mano Derecha", "Mano Izquierda", "Total"),
  Frecuencia = c(199, 110, 309)
)

frecuencia_altura_total <- data.frame(
  AlturaSaque = c("Abajo de la Cintura", "Arriba de la Cintura", "Arriba de los Hombros", "Total"),
  Frecuencia = c(60, 142, 107, 309)
)

# Análisis: Tabla de contingencia entre Mano utilizada y Altura del saque
tabla_contingencia <- matrix(c(70, 50, 140, 69, 31, 108), ncol = 3, byrow = TRUE)
colnames(tabla_contingencia) <- c("Abajo de la Cintura", "Arriba de la Cintura", "Arriba de los Hombros")
rownames(tabla_contingencia) <- c("Mano Derecha", "Mano Izquierda")

# Realizar la prueba de independencia con el test de chi-cuadrado
resultado_prueba <- chisq.test(tabla_contingencia)

# Extraer resultados del análisis
chi_square_statistic <- resultado_prueba$statistic
valor_p <- resultado_prueba$p.value
grados_libertad <- resultado_prueba$parameter
tabla_esperada <- round(resultado_prueba$expected, 2)

# Preparar resultados para tablas
tabla_observada <- as.data.frame(tabla_contingencia)
tabla_esperada_df <- as.data.frame(tabla_esperada)
colnames(tabla_observada) <- colnames(tabla_contingencia)
rownames(tabla_esperada_df) <- rownames(tabla_contingencia)

# Crear tabla resumen de resultados
resumen_resultados <- data.frame(
  "Estadístico Chi-cuadrado" = chi_square_statistic,
  "Grados de Libertad" = grados_libertad,
  "Valor P" = valor_p
)

#print(Final de Proyecto)

