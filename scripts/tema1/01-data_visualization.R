#Data Visualization - 6th October 2021
library(tidyverse)

#tidyverse 1.3.1 ──
# ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
# ✓ tibble  3.1.5     ✓ dplyr   1.0.7
# ✓ tidyr   1.1.4     ✓ stringr 1.4.0
# ✓ readr   2.0.2     ✓ forcats 0.5.1


#Preguntas que nos plantean:

#Los coches con motor más grande consumen más combustible
#que los coches con motor más pequeño.
#La relación consumo / tamaño es lineal? Es no lineal? Es exponencial?
#Es positiva? Es negativa?

View(mpg)
?mpg #help(mpg)
# displ: Tamaño de la cilindrada del motor del vehículo en litros.
# hwy: nº de millas recorridas en autopista por galón de combustible. (3,785411784 litros)
# Es una medida de la eficencia energética cuando el coche va por la autopista, cuántas millas
#es capaz de recorrer sólo con un galón de gasolina. 

#Scatter plot(nube de puntos)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# Este gráfico nos muestra una relación negativa entre el tamaño del motor
# y la eficiencia energética del combustible, es decir, cuánto mayor es el motor, 
# menos millas hace el coche, menor eficiencia y por tanto, más gasta el vehículo. 