
# Visualización de datos con ggplot2 ----

library(tidyverse)

## Preguntas de esta tarea:

# 1. Si ejecutas ggplot(data = mpg), ¿qué observas?

ggplot(data=mpg)

#RESPUESTA: No se observa nada ya que no hemos añadido ninguna capa con la 
#representación gráfica.


# 2. Indica el número de filas que tiene el data frame mpg. ¿Qué significa 
# cada fila?

dim(mpg)[1]

#RESPUESTA: El data frame mpg contiene 234 filas. Cada fila representa un 
# vehículo.



# 3. Indica el número de columnas que tiene el data frame mpg. ¿Qué significa 
# cada columna?

dim(mpg)[2]

#RESPUESTA: El data frame mpg contiene 11 columnas. Cada columna representa
# una característica del vehículo.



# 4. Observa la variable drv del data frame. ¿Qué describe? Recuerda que 
# puedes usar la instrucción ?mpg para consultarlo directamente en R.

mpg["drv"]

#RESPUESTA: La variable drv es el tipo de tren motriz del vehículo. Está 
#compuesta por tres categorías:
# f: correspondiente a tracción delantera.
# r: correspondiente a tracción trasera.
# 4: correspondiente a tracción en las cuatros ruedas.



# 5. Realiza un scatterplot de la variable hwy vs cyl. ¿Qué observas?

ggplot(data=mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))

#RESPUESTA: En este gráfico se puede observar que a mayor número de cilindros 
#tenga el motor, menor es la eficiencia energética del combustible ya que
#recorre menos millas por galón por la autopista.


   
# 6. Realiza un scatterplot de la variable cty vs cyl. ¿Qué observas?

ggplot(data=mpg) +
  geom_point(mapping = aes(x = cty, y = cyl)) 

#RESPUESTA: En este gráfico se puede observar que a mayor número de cilindros 
#tenga el motor, menor es la eficiencia energética del combustible ya que
#recorre menos millas por galón por la ciudad.



# 7. Realiza un scatterplot de la variable class vs drv. ¿Qué observas? 
# ¿Es útil este diagrama? ¿Por qué?

ggplot(data=mpg) +
  geom_point(mapping = aes(x = class, y = drv)) 

 #RESPUESTA: Este gráfico no aporta ninguna información relevante.