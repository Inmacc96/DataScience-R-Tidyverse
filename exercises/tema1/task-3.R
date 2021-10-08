
# Subplots con facets ----

library(tidyverse)

# Preguntas de esta tarea:

# 1. ¿Qué ocurre si hacemos un facet de una variable contínua?

# RESPUESTA: Lo que ocurre es que se crearía un subgráfico para cada valor
# distinto de la variable continua. No tendría mucho sentido hacerlo.

   
# 2. ¿Qué significa si alguna celda queda vacía en el gráfico 
# facet_grid(drv~cyl)?
# ¿Qué relación guardan esos huecos vacíos con el gráfico siguiente?
#   
#   ggplot(data = mpg) +
#   geom_point(mapping = aes(x=drv, y = cyl)) 
# 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=drv, y = cyl))
  
# RESPUESTA: Si la celda está vacía, significa que no existen vehículos que presentan
# la categoria de ambas variables conjuntamente.

# La relación que guardan ambos gráficos es que comparten los huecos
#vacíos ya que para esos pares de categorías no existen vehículos.



# 3. ¿Qué gráficos generan las siguientes dos instrucciones? 
# ¿Qué hace el punto? ¿Qué diferencias hay de escribir la variable 
# antes o después de la virgula?

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(.~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~.)

# RESPUESTA: En el primer gráfico se genera cuatro subplots, cada uno correspondiente
# a las 4 categorías de cyl. En el segundo gráfico se general 3 subplots, cada uno
#correspondiente a las 3 categorias de drv.
# El punto indica que se categorizará el gráfico en función de una sola variable.
# La diferencia es que en el primer caso, los subplots se generan por columnas y 
#en el segundo se generan por filas.

# 4. El primer facet que hemos pintado era el siguiente:
#   
#   ggplot(data = mpg) +
#   geom_point(mapping = aes(x = displ, y = hwy)) +
#   facet_wrap(~class, nrow = 3)
# 
# ¿Qué ventajas crees que tiene usar facets en lugar de la estética del color? 
# ¿Qué desventajas? ¿Qué cambiaría si tu dataset fuera mucho más grande?

# RESPUESTA: La ventaja que tiene los facets es la claridad que se obtiene frente
# a un único gráfico con distintos colores superpuestos. Sin embargo, la gran
#desventaja que tiene es el manejo de muchos gráficos simultáneamente.
# En el caso de un conjunto de datos pequeño, la opción ideal sería la estetica
# de color, ya que a simple vista podemos sacar buenos resultados. En cambio, para
#conjuntos de datos grande, esta opción es inviable ya que no podríamos ver nada, 
#y por tanto es mejor optar por los facets.

# 5. Investiga la documentación de ?facet_wrap y contesta a las siguientes preguntas:
#   
#   1.¿Qué hace el parámetro nrow?
#   2.¿Y el parámetro ncol?
#   3.¿Qué otras opciones sirven para controlar el layout de los paneles
#   individuales?
#   4.¿Por qué facet_grid() no tiene los parámetros de nrow ni de ncol?

# RESPUESTA: El parámetro nrow indica el nº de filas de subgráficos que
# se va a representar. Respectivamente, el parámetro ncol indica el nº de
# columnas.

# Otras opciones que puede usarse para controlar el layout, son:
# dir: si se desea el gráfico horizontal o vertical.
# switch: para fijar la posición en las labels.
# as.table: para representar las facetas como si fueran tablas con valores 
# mayores en la parte inferior derecha(TRUE) y en la parte superior 
# derecha(FALSE).

# facet_grid() no tiene parámetros nrow y ncol ya que éstos se determinan
# a partir de las categorías de las dos variables que se utiliza para el grid.

# 6. Razona la siguiente afirmación:
#   
#   Cuando representemos un facet con facet_grid() conviene poner la variable 
# con más niveles únicos en las columnas.

# RESPUESTA: Se realiza para tener una mejor visualización del resultado obtenido.
