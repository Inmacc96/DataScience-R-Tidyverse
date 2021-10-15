
# Ajustes avanzados de ggplot ----

library(tidyverse)

# Preguntas de esta tarea:

# 1. El siguiente gráfico que genera el código de R es correcto pero puede
# mejorarse. ¿Qué cosas añadirías para mejorarlo?

  ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) +
  geom_point()

# RESPUESTA: A este gráfico le añadiría una geometría smooth para ver la
  # tendencia que existe entre ambas variables. Además, agregaría la geometría
  #jitter para ayudar a entender la densidad de los puntos superpuestos.
  
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) +
    geom_point() +
    geom_smooth()+
    geom_jitter()
  
# 2. Investiga la documentación de geom_jitter(). ¿Qué parámetros controlan
# la cantidad de ruído aleatorio (jitter)?

# RESPUESTA: Los parámetros width y height controlan la cantidad de ruido
  # vertical y horizontal respectivamente.
  
  
# 3. Compara las funciones geom_jitter contra geom_count y busca semejanzas 
# y diferencias entre ambas.

# RESPUESTA: Ambas funciones aportan información sobre la densidad de los puntos
  #superpuestos en los gráficos. La diferencia es que geom_count cuenta el
  # número de observaciones en cada ubicación, y luego mapea el recuento 
  # en el área de puntos. Y por otro lado, geom_jitter añade una pequeña
  # cantidad de variación aleatoria a la ubicación de cada punto.
  
  
  
# 4. ¿Cual es el valor por defecto del parámetro position de un geom_boxplot? 
# Usa el dataset de diamonds o de mpg para hacer una visualización que
# lo demuestre.
  
# RESPUESTA: El valor por defecto del parámetros position de un goem_boxplot
  # es "dodge2". Esta función conserva la posición vertical de una geometría
  # mientras que ajusta la posición horizontal.
  
  ggplot(data = diamonds, mapping = aes(x = price )) +
    geom_boxplot(position = "dodge2")
  
# 5. Convierte un diagrama de barras apilado en un diagrama de sectores o 
# de tarta usando la función coord_polar()
  
# RESPUESTA:
  ggplot(data = diamonds, mapping = aes(x = cut, fill = color)) +
    geom_bar() +
    labs( x = NULL, y = NULL) +
    coord_polar()
  
# 6. ¿Qué hace la función labs()? Lee la documentación y explícalo
# correctamente.

  # RESPUESTA: La función labs() sirve para modificar el título, subtítulo, 
  #etiqueta de identificación para diferenciar entre varios gráficos, los nombres
  # de los ejes x e y y la leyenda del gráfico.
  
  
# 7. ¿En qué se diferencian las funciones coord_quickmap() y coord_map()?

  # RESPUESTA: coord_map() proyecta una porción de la tierra sobre un plano 2D 
  # utilizando cualquier proyección definida por el paquete mapproj.
  # Las proyecciones de mapas no conservan, en general, las líneas rectas, 
  # por lo que esto requiere un cálculo considerable. 
  # coord_quickmap() es una aproximación rápida que sí conserva las líneas 
  # rectas. Funciona mejor para áreas pequeñas más cercanas al ecuador.
  
  
# 8. Investiga las coordenadas coord_fixed() e indica su función.
  
  # RESPUESTA: Las coordenadas coord_fixed() obligan a establecer una relación
  #  espefícica entre la representación física de las unidades de datos en los ejes.
  # Esta relación representa el número de unidades en el eje Y que equivalen
  # a una unidad en el eje X. Por defecto, ratio = 1 y por tanto una unidad 
  # en el eje x tiene la misma longitud que una unidad en el eje y.

# 9. Investiga la geometría de la función geom_abline(), geom_vline() y 
# geom_hline() e indica su función respectivamente.

  # RESPUESTA: Las funciones geom_abline(), geom_vline() y geom_hline()
  # añaden líneas de referencias(rectas) a un gráfico en diagonal, vertical y 
  # horizontal respectivamente.
  
# 10. ¿Qué nos indica el gráfico siguiente acerca de la relación entre el 
# consumo en ciudad y en autopista del dataset de mpg?
#   
  ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point() + 
  geom_abline() + 
  coord_fixed()

# RESPUESTA: Este gráfico nos indica que la relación del consumo en ciudad
  # y consumo en autopista es lineal positiva: si un coche consume más por
  # ciudad, también consume más por autopista. El aspect ratio fixed nos 
  # ayuda en la representación para no confundirnos y pensar que una 
  # variable crece más rápida que la otra en el mismo. Además, si nos 
  # fijamos en el gráfico, vemos que los puntos están por encima de la recta
  # y=x, por tanto concluimos que el número de millas que podemos hacer en 
  # autopista con un galón de combustible es siempre superior al número de 
  # millas que haremos con ese mismo galón en ciudad (es decir, consumimos 
  # menos en autopista que en ciudad).