
# Filtrando los datos con dplyr ----

library(tidyverse)

## Preguntas de esta tarea ----

# 1. Encuentra todos los vuelos que llegaron más de una hora tarde de lo
# previsto.

# RESPUESTA:
 
  filter(flights, arr_delay > 60)


# 2. Encuentra todos los vuelos que volaron hacia San Francisco
# (aeropuertos SFO y OAK)

# RESPUESTA:

  filter(flights, dest %in% c("SFO", "OAK"))
  filter(flights, dest == "SFO" | dest == "OAK")
  

# 3. Encuentra todos los vuelos operados por United American (UA) o por 
# American Airlines (AA)

# RESPUESTA:
  
  filter(flights, carrier %in% c("UA","AA"))
  filter(flights, carrier == "UA" | carrier == "AA")
  
  
# 4. Encuentra todos los vuelos que salieron los meses de primavera 
# (Abril, Mayo y Junio)

# RESPUESTA:
  
  filter(flights, month %in% c(4,5,6))
  filter(flights, month == 4 | month == 5 | month == 6)
  
  
# 5. Encuentra todos los vuelos que llegaron más de una hora tarde pero 
# salieron con menos de una hora de retraso.

# RESPUESTA:
  
  filter(flights, arr_delay > 60, dep_delay < 60)
  
  
# 6. Encuentra todos los vuelos que salieron con más de una hora de retraso
# pero consiguieron llegar con menos de 30 minutos de retraso (el avión 
# aceleró en el aire)

# RESPUESTA:
  
  filter(flights, dep_delay > 60, arr_delay < 30)
  
  
# 7. Encuentra todos los vuelos que salen entre medianoche y las 7 de la
# mañana (vuelos nocturnos).

# RESPUESTA:
  
  filter(flights, hour >= 0, hour < 7)
  
  
# 8. Investiga el uso de la función between() de dplyr. ¿Qué hace? Puedes 
# usarlo para resolver la sintaxis necesaria para responder alguna de las 
# preguntas anteriores?

# RESPUESTA: La función between() es un atajo de hacer x >= left & x <= right.
# En la última pregunta, si usamos esta función sería:
  
  filter(flights, between(hour, 0, 6))

# 9. ¿Cuantos vuelos tienen un valor desconocido de dep_time?

# RESPUESTA: Hay 8255 vuelos sin la variable "dep_time".
  
  nrow(filter(flights, is.na(dep_time)))
  
# 10. ¿Qué variables del dataset contienen valores desconocidos? ¿Qué 
# representan esas filas donde faltan los datos?

# RESPUESTA: Las variables con valores perdidos son "dep_time", "dep_delay",
# "arr_time", "arr_delay", "tailnum", "air_time". Podrían ser correspondientes
  # a vuelos que se cancelaron.
  
  apply(is.na(flights),2, sum)
  
# 11.  Ahora vas a sorprenderte con la magia oscura... Contesta que dan
# las siguientes condiciones booleanas
# 
NA^0
NA|TRUE
FALSE&NA
# Intenta establecer la regla general para saber cuando es o no es NA
# (cuidado con NA*0)
  
# RESPUESTA: 
# NA^0 : 1
# NA|TRUE : TRUE
# FALSE&NA : FALSE
#NA domina las operaciones aritméticas, pero al tratarde de operaciones
# booleanas, True es un absorbente de la unión y False de la intersección.
  