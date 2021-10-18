
# Calculando nuevas variables con dplyr ----

library(tidyverse)

## Preguntas de esta tarea ----

# 1. El dataset de vuelos tiene dos variables, dep_time y sched_dep_time muy 
# útiles pero difíciles de usar por cómo vienen dadas al no ser variables
# contínuas. Fíjate que cuando pone 559, se refiere a que el vuelo salió a las 5:59... 

# Convierte este dato en otro más útil que represente el número de minutos
# que horas desde media noche. 

# RESPUESTA:

    View(transmute(flights,
           dep_time,
           dep_time_minute = dep_time %/% 100 * 60 + dep_time %% 100,
           sched_dep_time,
           sched_dep_time_minute = sched_dep_time %/% 100 * 60 + sched_dep_time %% 100 
           ))

# 2. Compara las variables air_time contra arr_time - dep_time. 
#    ¿Qué esperas ver?
#   ¿Qué ves realmente?
#   ¿Se te ocurre algo para mejorarlo y corregirlo?

# RESPUESTA:

View(transmute(flights,
            air_time,
            arr_time - dep_time))


View(transmute(flights,
               air_time,
               dep_time_minute = dep_time %/% 100 * 60 + dep_time %% 100,
               arr_time_minute = arr_time %/% 100 * 60 + arr_time %% 100,
               air_time_minute = arr_time_minute - dep_time_minute
               ))

# Debería de coincidir air_time y arr_time - dep_time pero habría que cambiar
# arr_time y dep_time a minutos, tampoco coincide con air_time.
# Aún así no coincide.


# 3. Compara los valores de dep_time, sched_dep_time y dep_delay. 
# Cómo deberían relacionarse estos tres números? Compruébalo y haz las 
# correcciones numéricas que necesitas.

# RESPUESTA dep_time - sched_dep_time = dep_delay, sin embargo, habría que 
# transformar dep_time y sched_dep_time a minutos.
View(transmute(flights,
               dep_time_minute = dep_time %/% 100 * 60 + dep_time %% 100,
               sched_dep_time_minute = sched_dep_time %/% 100 * 60 + sched_dep_time %% 100,
               dep_delay,
               new_dep_delay = dep_time_minute - sched_dep_time_minute))

# 4. Usa una de las funciones de ranking para quedarte con los 10 vuelos 
# más retrasados de todos. 

# RESPUESTA:
View(head(arrange(mutate(flights,
       time_gain = arr_delay - dep_delay,
       rank = min_rank(time_gain)
       ),desc(rank)), 10) )

# 5. Aunque la ejecución te de una advertencia, qué resultado te da la operación

1:6 + 1:20

# RESPUESTA: 2  4  6  8 10 12  8 10 12 14 16 18 14 16 18 20 22 24 20 22
# Va sumando cada elemento de ambos vectores hasta que el primero acaba
# y vuelve desde el principio sumándolos con los siguientes elementos 
# del segundo.

# 6. Además de todas las funciones que hemos dicho, las trigonométricas
# también son funciones vectoriales que podemos usar para hacer 
# transformaciones con mutate. Investiga cuales trae R y cual es 
#la sintaxis de cada una de ellas.

# RESPUESTA: sin(x), cos(x), tan(x), acos(x), asin(x), atan(x), 
# cospi(x) = cos(pi*x), sinpi(x) = sin(pi*x), tanpi(x) = tan(pi*x)
# donde x es el ángulo dado en radianes.

