
# Data transform ----

library(tidyverse)
library(nycflights13)

# data:
nycflights13::flights #Vuelos que salieron de NY en 2013.
?flights
View(flights)

#tibble es un dataframe mejorado para tidyverse.

## Tipos de variables:
## * int -> números enteros
## * dbl -> números reales (double)
## * chr -> vector de caracteres o strings
## * dttm -> date + time
## * lgl -> logical, contiene valores booleanos (T o F)
## * fctr -> factor, variables categóricas
## * date -> fecha (día, mes y año)


## Funciones para manipulación de datos:
## * filter() -> filtrar observaciones a partir de valores concretos
## * arrange() -> reordenar las filas
## * select() -> seleccionar variables por sus nombres
## * mutate() -> crea nuevas variables con funciones a partir de las existentes
## * summarise() -> colapsar varios valores para dar un resumen de los mismos

## * group_by() -> opera la función a la que acompaña grupo a grupo

## Argumentos de estas funciones:
# 1 - data frame
# 2 - operaciones que queremos hacer a las variables del data frame
# 3 - resultado en un nuevo data frame


### FILTER ----

# Todos los vuelos que salieron el 1 de Enero.
jan1 <- filter(flights, month == 1, day == 1)

# Todos los vuelos que salieron el día de mi cumpleaños
sept23 <- filter(flights, month == 9, day == 23)

# Todos los vuelos que salieron el día de navidad.
(dic25 <- filter(flights, month == 12, day == 25))

# Signos de comparación:
# >, >=, <, <=, ==, !=

## Problemas con la igualdad
2==2
sqrt(2)^2 == 2
near(sqrt(2)^2,2)
1/49 * 49 == 1
near(1/49 * 49 , 1)

## Álgebra de Bool:
# & : Conjunción
# | : Disyunción
# ! : Negación
# xor(): Disyunción exclusiva


# Todos los vuelos que salieron en Mayo o en Junio.
filter(flights, month == 5 | month == 6)

# INCORRECTO:
filter(flights, month == 5 | 6)

may_june <- filter(flights, month  %in% c(5,6))

## LEYES DE MORGAN:
# !(x & y) == (!x) | (!y)
# !(x | y) == (!x) & (!y)

# Vuelos que salieron con no más de una hora de retraso ni en salida ni en llegada
filter(flights, !(arr_delay > 60 | dep_delay > 60))
filter(flights, arr_delay <= 60, dep_delay <= 60)

# NOTA: Intentar siempre filtrar a partir de variables explicitas del data frame.


## VALORES FALTANTES:

NA > 0
10 == NA
NA + 5
NA / 5
NA == NA

# La tía Mery tiene una edad desconocida. No sé como de vieja es...
age_mery <- NA

# El tío John también hace mucho que no lo veo y no sé cuantos años tendrá.
age_john <- NA

# ¿Deben tener la misma edad John y Mery?
age_mery == age_john

# Nota: Cualquier operación que hagamos con NA acabará obteniéndose otro NA.

is.na(age_mery)

df <- tibble(x = c(1,2,NA,4,5))
filter(df, x > 2)
filter(df, is.na(x) | x > 2)

# NOTA: filter excluirá las filas con NA por defecto, para tenerlos en cuenta
# habría que usar is.na a la condición.

# Primeras y últimas filas del data frame
head(flights, 10)
tail(flights, 10)


### ARRANGE ----

# Todos los vuelos ordenados por año
arrange(flights, year)

# Todos los vuelos ordenados por año, luego por mes y por último por día.
sorted_date <- arrange(flights, year, month, day)

head(sorted_date)
tail(sorted_date)

# NOTA: Por defecto ARRANGE() ordena de menor a mayor.

# Todos los vuelos ordenados desde mayor tiempo de retraso de llegada a menor
#tiempo.
arrange(flights, desc(arr_delay))

# Los valores NA de la columna siempre quedarán al final.
arrange(df, desc(x))
arrange(df, x)

# Vuelo que menos distancia recorrió
arrange(flights, distance)[1,]

# Parece ser que directamente no partió

# Vuelo que más distancia recorrió
arrange(flights, desc(distance))[1,]



### SELECT ----

# Seleccionando filas:
View(sorted_date[1024:1068,])

# Seleccionando columnas(variables):
View(select(sorted_date[1024:1068,], dep_delay, arr_delay))

# Año, mes y día de todos los vuelos.
View(select(flights, year, month, day))
     
# Todos los vuelos con las variables desde dep_time hasta arr_delay
select(flights,dep_time:arr_delay)

# Todos los vuelos con todas las variables menos año, mes y día
select(flights,-(year:day))

# Todos los vuelos con aquellas variables comiencen por dep
select(flights, starts_with("dep"))

# Todas los vuelos con aquellas variables que terminen por delay
select(flights, ends_with("delay"))

# Todas los vuelos con aquellas variables que contengan una st
select(flights, contains("st"))

# Filtrado con expresión regular
select(flights, matches("(.)\\1")) # busca caracteres repetidos
#busca cualquier cosa que aparezca al menos dos veces

# Buscaría variables de la forma x1,x2,x3,x4,x5
select(flights, num_range("x", 1:5))

?select

### RENAME ----
# La diferencia es que mantiene el resto de variables, cosa que no
#ocurre con select, que las descarta.

rename(flights, deptime = dep_time)

select(flights, deptime = dep_time)

# También podría usar everything() para que aparezcan el resto
# de variables. De esta forma tambien podemos ordenar las columnas
# introduciendo primero el orden de las variables que queremos tener
# primero y luego con everything añadir el resto.
select(flights, time_hour, distance, air_time, everything())



### MUTATE ----

flights_new <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)

# Añadimos las variables ganancia de tiempo, tiempo del vuelo por horas,
# velocidad del vuelo, ganancia de tiempo por horas(minutos que se retrasa o 
# adelante en 1 hora).
flights_new <- mutate(flights_new,
       time_gain = arr_delay - dep_delay, #diff_t (min)
       air_time_hour = air_time / 60,
       flight_speed = distance / air_time_hour, # v = s/t (km/h)
       time_gain_per_hour = time_gain / air_time_hour
       )

# Si queremos obtener un dataset exclusivamente con las nuevas variables creadas
# usamos la función transmute.
transmute(flights_new,
            time_gain = arr_delay - dep_delay, 
            air_time_hour = air_time / 60,
            flight_speed = distance / air_time_hour, 
            time_gain_per_hour = time_gain / air_time_hour) -> data_from_flights


### Funciones útiles para mutar los datos ----

# * Operaciones aritmétricas: +, - , * , / , ^  (hours + 60 * minutes)
# * Agregados de funciones: x/sum(x): proporción sobre el total
#                           x - mean(x): distancia respecto de media
#                           (x - mean(x))/sd(x): tipificación de los datos
#                           (x - min(x))/(max(x) - min(x)): estandarizar entre [0,1]
# * Aritmétrica modular: %/%: cociente de la división entera
#                        %%: resto de la división entera
#                        x == y * (x%/%y) + (x%%y) ALGORITMO DE EUCLIDES

# Obtenemos del tiempo del vuelo, las horas y minutos de ese vuelo.
transmute(flights,
          air_time,
          hour_air = air_time %/% 60,
          minute_air = air_time %% 60)

# * Logaritmos: log() -> logaritmo en base e, log2(), log10()
# * Offsets: lead() -> Mueve hacia la izquierda, lag() -> Mueve hacia la derecha
df <- 1:12
lag(df)
lead(df)
lead(lag(df))

# * Funciones acumulativas -> cumsum(), cumprod(), cummin(), cummax(), cummean()
cumsum(df)
cumprod(df)
cummin(df)
cummax(df)
cummean(df)

# * Comparaciones lógicas: >, >=, <, <=, ==, !=
# Creamos un variable para ver o no si los vuelos fueron retrasados.
transmute(flights,
          dep_delay,
          has_been_delayed = (dep_delay > 0)
)

# *Rankings:min_rank() -> posiciones del vector ordenado
df <- c(7,1,2,5,3,8,NA,3,4,-2)
df
min_rank(df)
# Variantes a min_rank(): row_number() NO hay posiciones repetidas
# dense_rank(), percent_rank() Porcentaje respecto al total,
# cume_dist() Porcentaje acumulado redondeado
# ntile() Distribución por cuantiles
row_number(df)
dense_rank(df)
cume_dist(df)
ntile(df, n = 4)

transmute(flights,
          dep_delay,
          ntile(dep_delay, n = 100)
)



### SUMMARISE ----

# El tiempo promedio de retraso de todos los vuelos de 2013 
summarise(flights,
          delay = mean(dep_delay, na.rm = T))

# Retraso por mes y año en promedio
by_month_group <- group_by(flights, year, month)
summarise(by_month_group, delay = mean(dep_delay, na.rm = T))

# Retraso diaro en promedio, mediana, min
by_day_group <- group_by(flights, year, month, day)
summarise(by_day_group, delay = mean(dep_delay, na.rm = T),
          median = median(dep_delay, na.rm = T),
          min = min(dep_delay, na.rm = T))

mutate(summarise(group_by(flights, carrier),
          delay = mean(dep_delay, na.rm = T),
          delay_median = median(dep_delay, na.rm = T)),
          sorted = min_rank(delay))
# La compañia que más tiende a retrasarse es F9 y la que menos US. Sin embargo
# si nos fijamos en la mediana, vemos que la mayoría tienden a no retrasarse
#En este caso la media no es una medida buena para mirar el comportamiento
#global ya que hay unos pocos vuelos con altos retrasos por lo que 
#distorsiona la media.


## PIPES ----

group_by_dest <- group_by(flights, dest)
delay <- summarise(group_by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = T),
                   delay = mean(arr_delay, na.rm = T))
delay <- filter(delay, count > 100, dest != "HNL")

ggplot(data = delay , mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 0.2 ) +
  geom_smooth(se = F) +
  geom_text(aes(label = dest), alpha = 0.3)

# Vemos que a partir de aproximadamente 700 millas, el retraso
# se va disminuyendo.


delays <- flights %>%
  group_by(dest)  %>%
  summarise( 
    count = n(),
    dist = mean(distance, na.rm = T),
    delay = mean(arr_delay, na.rm = T)
  ) %>%
  filter(count > 100, dest != "HNL")

# x %>% f(y) <-> f(x,y)
# x %>% f(y) %>% g(z) <-> g(f(x,y),z)
# x %>% f(y) %>% g(z) %>% h(t) <-> h(g(f(x,y),z),t)

## ggvis <-> ggplot2
## Para escribir la tubería a través del teclado: cmd + shift + M

       