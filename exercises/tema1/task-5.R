
# Transformaciones estadísticas con ggplot ----

library(tidyverse)

## Preguntas de esta tarea:

# 1. ¿Qué hace el parámetro geom_col? ¿En qué se diferencia de geom_bar?

# RESPUESTA: geom_bar() hace que la altura de la barra sea proporcional
# al número de casos en cada grupo. Si desea que las alturas de las barras 
# representen valores de los datos, utilice geom_col() en su lugar. 
# geom_bar() utiliza stat_count() por defecto: cuenta el número de casos 
# en cada posición x. geom_col() utiliza stat_identity(): deja los datos 
# como están.

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = demo_diamonds) +
  geom_col(mapping = aes(x = cut, y = freqs))



# 2. La gran mayoría de geometrías y de stats vienen por parejas que siempre
# se utilizan en conjunto. Por ejemplo geom_bar con stats_count. Haz una pasada 
# por la documentación y la chuleta de ggplot y establece una relación entre
# esas parejas de funciones. ¿Qué tienen todas en común?


# RESPUESTA: geom_bar() / stat_count()
# geom_col() / stat_identity()
# geom_histogram() / stat_bin()
# geom_boxplot() / stat_boxplot()
# geom_density() / stat_density()
# geom_qq() / stat_qq()

# Lo que tienen en común es que toda transformación estadística se corresponde
# a una geométrica y ambos devuelven el mismo gráfico.

# 3. ¿Qué variables calcula la función stat_smooth? ¿Qué parámetros controlan 
# su comportamiento?

# RESPUESTA: La función stat_smooth calcula:
# y: valor predicho.
# ymin: Intervalo de confianza inferior en torno a la media
# ymax: Intervalo de confianza superior en torno a la media.
# se: Error estándar.
# Los parámetros que controlan su comportamiento son:
#x
#y
#alpha
#colour
#fill
#group
#linetype
#size
#weight
#ymax
#ymin


   
# 4. Cuando hemos pintado nuestro diagrama de barras con sus proporciones, 
# necesitamos configurar el parámetro group = 1. ¿Por qué?

# RESPUESTA: Para que haya una agrupación por las categorías de la variable x.
# La suma de todas las propociones de las categorías de x debe dar 1.
  
# 5. ¿Qué problema tienen los dos siguientes gráficos?

  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, y = ..prop..))

  ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))
  
# RESPUESTA: A ambos gráficos le falta la agrupación por el eje x para establecer
  # las proporciones, introduciendo group = 1.
  