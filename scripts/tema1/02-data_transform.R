
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

