
# Ordenación y selección de datos con dplyr ----

library(tidyverse)

## Preguntas de esta tarea ----

# 1. Piensa cómo podrías usar la función arrange() para colocar todos los 
# valores NA al inicio. Pista: puedes usar la función is.na() en lugar de la 
# función desc() como argumento de arrange.

# RESPUESTA:

arrange(df, !is.na(x))

# 2. Ordena los vuelos de flights para encontrar los vuelos más retrasados 
# en la salida. ¿Qué vuelos fueron los que salieron los primeros antes de
# lo previsto?

# RESPUESTA:

    arrange(flights,desc(dep_delay))[1,]
    arrange(flights, dep_delay)[1,]

# El vuelo más retrasado fue el 9 de enero de 2013 con 1301 minutos de retraso.
# Y el vuelo del 7 de diciembre de 2013 salió 43 minutos antes de la salida 
# prevista.

# 3. Ordena los vuelos de flights para encontrar los vuelos más rápidos. Usa
# el concepto de rapidez que consideres. 

# RESPUESTA:

    View(arrange(flights, desc(distance/air_time)))
  # El vuelo más rápido fue el 25 de Mayo.
    
# 4. ¿Qué vuelos tienen los trayectos más largos? Busca en Wikipedia qué dos 
# aeropuertos del dataset alojan los vuelos más largos. 

# RESPUESTA:
    
    View(distinct(arrange(select(flights, origin, dest, distance),
                          desc(distance))))

# Vuelos desde JFK(Aeropuerto Internacional John F. Kennedy) de Nueva York o
# EWR(Aeropuerto Internacional Libertad de Newark) de Nueva Jersey hasta HNL
# (Aeropuerto Internacional de Honolulu) de Hawái con una distancia de 4983 millas.
    
# 5. ¿Qué vuelos tienen los trayectos más cortos? Busca en Wikipedia qué dos
# aeropuertos del dataset alojan los vuelos más largos. 

# RESPUESTA:
    
    View(distinct(arrange(select(flights, origin, dest, distance), distance)))

# Vuelos desde EWR(Aeropuerto Internacional Libertad de Newark) de Nueva Jersey
# a LGA(Aeropuerto Internacional de La Guardia) de Nueva York con una distancia
# de 17 millas.
    
    
# 6. Dale al coco para pensar cuantas más maneras posibles de seleccionar
# los campos dep_time, dep_delay, arr_time y arr_delay del dataset de flights. 

# RESPUESTA:
    
    select(flights, dep_time, dep_delay, arr_time, arr_delay)
    select(flights, matches("^dep") | matches("^arr"))
    select(flights, starts_with("dep") | starts_with("arr"))
    select(flights, (ends_with("time") | ends_with("delay")) &
             !starts_with("sched") & !starts_with("air"))
    
# 7. ¿Qué ocurre si pones el nombre de una misma variable varias veces en 
# una select()?

# RESPUESTA:
    
    select(flights, dep_time, dep_time, dep_delay)
    
# Devuelve esa variable una sola vez. No se repite la columna.
    
# 8. Investiga el uso de la función one_of() de dplyr. 

# RESPUESTA: Permite añadir las variables en string dentro de un vector. Muy útil
# si el resultado de un programa ha devuelto un array de variables que queremos
# seleccionar automáticamente.

# Si no existe una columna dará error:
      
      select(flights, c("dep_time", "col_bad","distance","arr_time") ) 
    
# one_of chequea si existe la columna y no dará error:
      
      select(flights, one_of( c("dep_time", "col_bad","distance","arr_time") ) ) 
    
# 9. Investiga cómo puede ser útil la función one_of() de la pregunta anterior
# en conjunción con el vector de variables 

# c("year", "month", "day", "dep_delay", "arr_delay")

# RESPUESTA:
    select(flights, one_of(c("year", "month", "day", "dep_delay", "arr_delay")))
    
    
# 10. Intenta averiguar el resultado del siguiente código. Luego ejecútalo 
# y a ver si el resultado te sorprende.
# 
select(flights, contains("time"))
# 
# Intenta averiguar cómo lo hacen las funciones de ayuda de la select 
# para tratar el caso por defecto y cómo lo puedes cambiar.
    
# RESPUESTA:
# Nos devuelve todas las variables que tienen la palabra "time" en su nombre.
# Muy útil cuando queremos localizar todo lo que tiene que ver con tiempo.