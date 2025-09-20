# An-lisis-Ping-Pong
Análisis estadístico de precisión en saques de ping pong usando modelo binomial negativo

Análisis Estadístico — "Ping Pong" 🏓
Autor: Samir Leonardo Caizapasto Hernández 
Fechas: 15/09/2024 – 15/02/2025
📊 Resumen
Diseñé y ejecuté un estudio experimental con 309 observaciones para evaluar precisión en saques de ping pong bajo condiciones controladas. Implementé análisis descriptivo, bivariado, y validé un modelo binomial negativo (k=3, p=0.3) mediante pruebas de hipótesis e intervalos de confianza.

🎯 Objetivos
Objetivo General:
Analizar el comportamiento estadístico de la precisión en lanzamientos de ping pong mediante un modelo binomial negativo, para desarrollar un sistema predictivo de probabilidad de éxito.

Objetivos Específicos:
Validar ajuste del modelo binomial negativo mediante pruebas chi-cuadrado
Determinar diferencias significativas en tiempo promedio de saque vs valor teórico 2s
Evaluar proporción de jugadores diestros en la población
Analizar relación entre variables categóricas mano dominante vs altura de saque
Cuantificar correlación entre número de intentos y tiempo de saque

📁 Contenido del Repositorio
📦 analisis-ping-pong-estadistica/
├── 📄 README.md
├── 📊 data/
│   └── datos_pingpong.csv
├── 📝 scripts/
│   └── analisis_estadistico.R
├── 📈 figures/
│   ├── distribucion_intentos.png
│   ├── correlacion_tiempo_intentos.png
│   └── boxplot_mano_dominante.png
├── 📑 docs/
│   └── reporte_interactivo.html
├── 📋 paper_pingpong.pdf
└── 📊 presentacion_proyecto.pdf

🔬 Metodología
Variables Analizadas:
Categóricas: Mano dominante, Altura de saque
Cuantitativas: Número de intentos, Tiempo de saque

Técnicas Estadísticas:
Análisis descriptivo univariado y bivariado
Modelo binomial negativo (k=3, p=0.3)
Pruebas de hipótesis e intervalos de confianza
Análisis de correlación y contingencia

📈 Hallazgos Principales
Resultado Valor Interpretación Ajuste del modelo p = 0.6603✅ Se ajusta bien a binomial negativa 
Tiempo promedio 1.945 ± 0.320s Significativamente menor a 2s 
Correlación intentos-tiempo r = 0.65📈 Correlación positiva moderada 
Proporción diestros64.4% Similar a población general
🔧 Cómo Reproducir
Prerrequisitos:
rinstall.packages(c("ggplot2", "dplyr", "e1071", "readxl", "knitr"))
Ejecución:
 1. Clonar repositorio
git clone https://github.com/Sam-24-dev/analisis-ping-pong-estadistica.git
# 2. Abrir en RStudio
# 3. Ejecutar scripts/analisis_estadistico.R
# 4. Ver docs/reporte_interactivo.html en navegador

📊 Visualizaciones Clave
Distribución de intentos: Histograma con ajuste binomial negativo
Correlación tiempo-intentos: Gráfico de dispersión con línea de tendencia
Análisis categórico: Boxplots por mano dominante y altura de saque
Tablas de contingencia: Relación entre variables categóricas

🎓 Conclusiones Estadísticas
Modelo validado: Los datos se ajustan significativamente al modelo binomial negativo propuesto
Eficiencia temporal: Los participantes realizan saques más rápidos que el tiempo de referencia
Efecto de fatiga: Correlación positiva sugiere aumento de tiempo con más intentos
Independencia de variables: No hay asociación significativa entre mano dominante y altura de saque

🔗 Enlaces
Reporte Interactivo: Ver análisis completo
Paper Académico: paper_pingpong.pdf
Presentación: presentacion_proyecto.pdf

🛠️ Tecnologías Utilizadas
Mostrar imagen
Mostrar imagen
Mostrar imagen
📧 Contacto
Samir Leonardo Caizapasto Hernández
Email: scaizapa@espol.edu.ec
GitHub: Sam-24-dev
LinkedIn: Perfil Profesional

Este proyecto está bajo la Licencia MIT - ver el archivo LICENSE para detalles.

⭐ Si te parece útil este análisis, dale una estrella al repositorio
