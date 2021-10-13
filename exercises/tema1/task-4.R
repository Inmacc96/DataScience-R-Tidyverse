
# Geometrías con ggplot2 ----

library(tidyverse)

## Preguntas de esta tarea:

# 1. Ejecuta este código en tu cabeza y predice el resultado. Luego ejecutalo 
# en R y comprueba tu hipótesis:
#   
  ggplot(data = mpg, mapping = aes(x=displ, y = hwy,color = drv)) +
  geom_point() +
  geom_smooth( se = F)

# RESPUESTA: En este gráfico aparecerá la nube de puntos entre las variables
# displ y hwy, distinguiendo cada punto por un color correspondiente a una clase
# de la variable drv. Además habrá una geometría smooth asociada a cada clase de drv,
# sin el intervalo de confianza.

# 2. Qué hace el parámetro show.legend = F? ¿Qué pasa si lo eliminamos?
# ¿Cuando lo añadirías y cuando lo quitarías?
#   
  
# RESPUESTA: El parámetro show.legend = F, fuerza a que no se represente
# la leyenda del gráfico. Se añadiría cuando la leyenda no nos aporta ninguna 
# información adicional, por ejemplo que solamente haya un color asociado a
  # la única clase de la variable. En cambio, se eliminaría show.legend = F
  #cuando sí necesitamos la leyenda para entender el gráfico.
  
  
# 3. ¿Qué hace el parámetro se de la función geom_smooth()? ¿Qué pasa si
# lo eliminamos? ¿Cuando lo añadirías y cuando lo quitarías?
  
# RESPUESTA: El parámetro "se" de la función geom_smooth representa o no 
  #el intervalo de confianza del ajuste. 

  
  
# 4. Describe qué hacen los dos siguientes gráficos y di si serán igual y
# diferente. Justifica tu respuesta.
# 
# ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
#   
#   geom_point() + 
#   geom_smooth()
# 
# ggplot(data = mpg) + 
#   geom_point(mapping = aes(x=displ, y = hwy)) + 
#   geom_smooth(mapping = aes(x=displ, y = hwy))


# RESPUESTA: Hacen exactamente lo mismo, sin embargo en el primer caso, la
  #estética está definida globalmente para todas las geometrías y en el segundo
  #caso las estéticas están definidas de manera local para cada una de las geometrías.
  
  
# 5. Reproduce el código de R que te genera el siguiente gráfico.

# RESPUESTA:
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point()+
    geom_smooth( se = F )
  
  
# 6. Reproduce el código de R que te genera el siguiente gráfico.
  
# RESPUESTA:
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point() +
    geom_smooth(se = F, mapping = aes(group = drv))
    
  
  
# 7. Reproduce el código de R que te genera el siguiente gráfico.
  
# RESPUESTA:
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
    geom_point() +
    geom_smooth(se = F)
  
  
  
# 8. Reproduce el código de R que te genera el siguiente gráfico.
  
# RESPUESTA:
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point( mapping = aes(color = drv, shape = drv)) +
    geom_smooth(se = F)
  
# 9. Reproduce el código de R que te genera el siguiente gráfico.
  
# RESPUESTA:
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point( mapping = aes(color = drv, shape = drv)) +
    geom_smooth(se = F, mapping = aes(linetype = drv))
  
# 10. Reproduce el código de R que te genera el siguiente gráfico.
  
# RESPUESTA:
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point( mapping = aes(fill = drv),
                shape = 23, stroke = 2, color = "white", size = 4) 
  
  
  