
# Examen 1: Filtrado y manipulación de datos ----

library(tidyverse)
library(nycflights13)

## Preguntas de esta tarea.

# 1. Intenta describir con frases entendibles el conjunto de vuelos
# retrasados. Intenta dar afirmaciones como por ejemplo:

# - Un vuelo tiende a salir unos 20 minutos antes el 50% de las veces 
# y a salir tarde el 50% de las veces restantes.

# - Los vuelos de la compañía XX llegan siempre 20 minutos tarde

# - El 95% de los vuelos a HNL llegan a tiempo, pero el 5% restante 
# se retrasan más de 3 horas.

# Intenta dar por lo menos 5 afirmaciones verídicas en base a los
# datos que tenemos disponibles.


# RESPUESTA:

flights_delayed <- flights %>% 
  filter(dep_delay>0, arr_delay>0)

View(flights %>%
  group_by(carrier) %>% 
  summarise( mean_dep_delay = mean(dep_delay, na.rm = T),
             min = min(dep_delay, na.rm = T),
             q1 = quantile(dep_delay, 0.25, na.rm = T),
             median = quantile(dep_delay, 0.5, na.rm = T),
             q3 = quantile(dep_delay, 0.75, na.rm = T),
             max = max(dep_delay, na.rm = T)) %>% 
    arrange(desc(max)))
# Hay aviones de la compañía HA que se han retrasado en la salida 22 horas aprox
# casi un día. Por otro lado, el 50 % de los vuelos de esta compañía tiende a salir
# 4 minutos antes y el otro 50% tiende a salir más tarde de 4 minutos antes.
# El 75% de los aviones de esta compañía tiende a salir un minuto antes de lo 
#previsto o incluso antes, y el 25% restante tienden a salir un minuto antes o
# más tarde. Por tanto, en esta compañía los aviones suelen salir antes.

View(flights %>%
      group_by(carrier) %>% 
      summarise( mean_arr_delay = mean(arr_delay, na.rm = T),
                 min = min(arr_delay, na.rm = T),
                 q1 = quantile(arr_delay, 0.25, na.rm = T),
                 median = quantile(arr_delay, 0.5, na.rm = T),
                 q3 = quantile(arr_delay, 0.75, na.rm = T),
                 max = max(arr_delay, na.rm = T)) %>% 
       arrange(desc(max)))
# A su vez, el 50% de los aviones de la compañía HA tienden ha llegar 13 minutos
#antes.  

View(flights %>%
       group_by(tailnum) %>% 
       summarise( mean_dep_delay = mean(dep_delay, na.rm = T),
                  min = min(dep_delay, na.rm = T),
                  q1 = quantile(dep_delay, 0.25, na.rm = T),
                  median = quantile(dep_delay, 0.5, na.rm = T),
                  q3 = quantile(dep_delay, 0.75, na.rm = T),
                  max = max(dep_delay, na.rm = T)))
# El avión N0EGMQ tiende a salir 4 minutos antes el 50% de las veces y a salir
# tarde el 50% de las veces restantes.

View(flights %>%
       group_by(dest) %>% 
       summarise( mean_dep_delay = mean(dep_delay, na.rm = T),
                  min = min(dep_delay, na.rm = T),
                  q1 = quantile(dep_delay, 0.25, na.rm = T),
                  median = quantile(dep_delay, 0.5, na.rm = T),
                  q3 = quantile(dep_delay, 0.75, na.rm = T),
                  q95 = quantile(dep_delay, 0.95, na.rm =T),
                  max = max(dep_delay, na.rm = T)))


#¿Cuál es la compañía con más retrasos?
View(flights %>% 
  group_by(carrier) %>% 
  summarise(prop_delay = sum(dep_delay>0, na.rm=T)/n(),
            sum_delay = sum(dep_delay>0, na.rm=T),
            total=n()) %>% 
  arrange(desc(prop_delay)))
  
# La compañía WN es la que ha tenido más nº de retrasos.

#¿Cuál es la compañía con más minutos de retrasos?
View(flights %>% 
       group_by(carrier) %>% 
       summarise(mean_arr_delay = mean(arr_delay, na.rm=T),
                 ) %>% 
       arrange(desc(mean_arr_delay)))

# La compañía F9 es aquella con más minutos de retraso en promedio 22 min

#¿Cuál es la compañia que más distancia hace?
flights %>% 
  group_by(carrier) %>% 
  summarise(dist_total = sum(distance),
            dist_mean = mean(distance),
            dist_max = max(distance)) %>% 
  arrange(desc(dist_max))

# La compañía HA es la que que recorre más millas y sin embargo es la que 
# menos retrasos ha tenido.

# ¿Cuál es el avión que más millas ha recorrido?
flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay)) %>% 
  group_by(tailnum) %>% 
  summarise(dist_total = sum(distance)) %>% 
  arrange(desc(dist_total))

# El avión que más millas ha recorrido en 2013 es N328AA con 929090 millas.

# ¿Cuál es el mes que más aviones han salido?
flights %>% 
  filter(!is.na(dep_delay)) %>% 
  group_by(year, month) %>% 
  summarise(n = n()) %>% 
  arrange(n)
# El mes con menos vuelos es en febrero y con más vuelos en agosto.

#¿Cuál es el destino que más se frecuencia?
flights %>% 
  filter(!is.na(arr_delay)) %>% 
  group_by(dest) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))
# Los destinos más frecuentado son ATL, ORD y LAX.

# ¿Cuál es el destino que más veces tiene retraso de llegada?
View(flights %>% 
  group_by(dest) %>% 
  summarise(prop_delay = sum(arr_delay>0,na.rm=T) / n(),
            sum_n = sum(arr_delay>0,na.rm=T),
            total = n()
          ) %>% 
  arrange(desc(prop_delay)))
#Los vuelos se retrasan más veces cuando van a CAE. Un 75% de los vuelos
# que han ido a CAE se han retrasado.

#¿Cuál es el destino del vuelo con más retraso?
flights %>% 
  filter(arr_delay == max(arr_delay, na.rm=T))  %>% 
  select(month, day, arr_delay, dest)
# El vuelo con mayor retraso fue el 9 de Enero hacia HNL y un retraso
# de aproximadamente 22 horas.

#¿En que mes se suelen retrasar más los aviones?
flights %>% 
  group_by(year, month) %>% 
  summarise(prop_delay = sum(arr_delay>0,na.rm=T) / n(),
            sum_n = sum(arr_delay>0,na.rm=T),
            total = n()
  ) %>% 
  arrange(desc(prop_delay))
# El mes con más retraso es Diciembre. Un 51% de los vuelos se han retrasado
# a la llegada.

# ¿Cuál es el recorrido con mayor número de vuelos?
flights %>% 
  group_by(origin, dest) %>% 
  filter(!is.na(arr_delay), !is.na(dep_delay)) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))
# La mayor cantidad de vuelos se realizaron de JFK hacia LAX.


# 2. Da una versión equivalente a las pipes siguientes sin usar la función 
# count:

# not_cancelled %>% count(dest)
#
# not_cancelled %>% count(tailnum, wt = distance)

# RESPUESTA:

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(n = n())

not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(total_distance = sum(distance))


# 3. Para definir un vuelo cancelado hemos usado la función

# (is.na(dep_delay) | is.na(arr_delay))

# Intenta dar una definición que sea mejor, ya que la nuestra es un poco 
# subóptima. ¿Cuál es la columna más importante?

# RESPUESTA:

# La columna más importante sería arr_delay, ya que si el avion no 
# ha llegado a su destino, significa que se ha cancelado.

not_cancelled <- flights %>%
  filter(!is.na(arr_delay))

not_cancelled2 <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))


# 4. Investiga si existe algún patrón del número de vuelos que se cancelan 
# cada día.

# Investiga si la proporción de vuelos cancelados está relacionada con 
# el retraso promedio por día en los vuelos.

# Investiga si la proporción de vuelos cancelados está relacionada con 
# el retraso promedio por aeropuerto en los vuelos.

# ¿Qué compañía aérea sufre los peores retrasos?

# RESPUESTA:

flights %>% 
  group_by(year, month, day) %>% 
  summarise(n_flight_cancelled = sum(is.na(arr_delay))) %>% 
  ggplot(mapping = aes(x = 1:365, y = n_flight_cancelled))  +
  geom_line() 

# No existe un patrón determinado.

# SIN ACABAR



# 5. Difícil: Intenta desentrañar los efectos que producen los 
# retrasos por culpa de malos aeropuertos vs malas compañías aéreas. 
# Por ejemplo, intenta usar 

flights %>% group_by(carrier, dest) %>% summarise(n())

# RESPUESTA:


