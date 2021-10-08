
# Estéticas en ggplot2 ----

library(tidyverse)

## Preguntas de esta tarea:

# 1. Toma el siguiente fragmento de código y di qué está mal. ¿Por qué no 
# aparecen pintados los puntos de color verde?
  
  ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "green"))

# RESPUESTA: No es correcto ya que se ha añadido color dentro del mapping y
# por tanto, ha asociado la categoría "green" a un color que ha decidido. Para 
# que hiciese lo que queremos:
  
  ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), color = "green")

  
  
# 2. Toma el dataset de mpg anterior y di qué variables son categóricas.
  
  str(mpg)
  
# RESPUESTA: Las variables categóricas son "manufacturer", "model", "trans",
# "drv", "fl" y "class".

  
  
# 3. Toma el dataset de mpg anterior y di qué variables son contínuas.
  
# RESPUESTA: La única variable continua es "displ".
  
  

# 4. Dibuja las variables contínuas con color, tamaño y forma respectivamente.
  
  ggplot(data = mpg) +
    geom_point( mapping = aes(x = c(1:dim(mpg)[1]), y = displ),
                color = "red",
                size = 2,
                shape = 1)

  
  
# 5. ¿En qué se diferencian las estéticas para variables contínuas y categóricas?
  
# RESPUESTA: En las estéticas para variables continuas se representa el valor de
# dicha variable mientras que en las estéticas para variables categóricas se 
# presenta la categoría a la que pertenece la observación.
  
  
  
# 6. ¿Qué ocurre si haces un mapeo de la misma variable a múltiples estéticas?
  
# RESPUESTA: Nos muestras todas las observaciones bajo las múltiples estéticas
# que se han utilizado. Es decir, una observación vendrá dada por su color, tamaño
# y forma simultáneamente.
  
  
  
# 7. Vamos a conocer una estética nueva llamada stroke. ¿Qué hace?
# ¿Con qué formas funciona bien? 
  
  ggplot(data = mpg) +
    geom_point( mapping = aes(x = c(1:dim(mpg)[1]), y = displ),
                color = "red",
                fill = "blue",
                size = 10,
                shape = 1,
                stroke = 3 )
  
# RESPUESTA: La estética stroke modifica la anchura del borde del punto. Esta
  #estética funciona bien con aquellas formas que no tienen relleno, es decir,
  #las de 0 a 14, o también con las que tiene relleno y borde, es decir, las de
  # 21 a 25.
  
  
# 8. ¿Qué ocurre si haces un mapeo de una estética a algo que no sea 
# directamente el nombre de una variable (por ejemplo aes(color = displ < 4))?
  
  ggplot(data = mpg) +
    geom_point( mapping = aes(x = displ, y = hwy, color = displ < 4))
  
# RESPUESTA: En ese caso, lo interpreta como una variable binaria: las que
# cumple la condición frente a las que no.