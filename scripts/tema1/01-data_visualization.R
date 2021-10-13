#Data Visualization - 6th October 2021
library(tidyverse)

#tidyverse 1.3.1 ──
# ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
# ✓ tibble  3.1.5     ✓ dplyr   1.0.7
# ✓ tidyr   1.1.4     ✓ stringr 1.4.0
# ✓ readr   2.0.2     ✓ forcats 0.5.1


#Preguntas que nos plantean:

#Los coches con motor más grande consumen más combustible
#que los coches con motor más pequeño.
#La relación consumo / tamaño es lineal? Es no lineal? Es exponencial?
#Es positiva? Es negativa?

View(mpg)
?mpg #help(mpg)
# displ: Tamaño de la cilindrada del motor del vehículo en litros.
# hwy: nº de millas recorridas en autopista por galón de combustible. (3,785411784 litros)
# Es una medida de la eficencia energética cuando el coche va por la autopista, cuántas millas
#es capaz de recorrer sólo con un galón de gasolina. 

#Scatter plot(nube de puntos)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# Este gráfico nos muestra una relación negativa entre el tamaño del motor
# y la eficiencia energética del combustible, es decir, cuánto mayor es el motor, 
# menos millas hace el coche, menor eficiencia y por tanto, más gasta el vehículo. 


# Queremos ver si aquellos puntos que salen del patrón general, es decir aquellos
# con un alto displ y bajo hwy (denominados outliers) se corresponden a vehículos
#híbridos ya que así justificaría que se diese esta situación ya que no sólo gastan
# combustible sino que gastan electricidad.

#Para llevar a cabo lo anterior, vamos a utilizar la variable class y vamos a 
#a representar la nube de puntos en función de dicha variable. Para ello, se
#modifica la estética de los puntos "aes". La estética incluye la posición, el 
# tamaño, forma o incluso el color de los puntos.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# La conclusión que podemos sacar es que casi todos estos outliers (gran tamaño
#de motor pero bajo nivel de consumo) son coches 2seater, coches de dos asientos,
#es decir, coche para dos personas. Un 2seater podría ser un convertible, 
#un descapotable o coches pequeños. 
#En efecto, estos coches no tienen pinta de que vayan a ser híbridos, de hecho
#un coche de dos asientos es todo lo contrario, es un deportivo. Sin embargo, 
#parece ser que los coches deportivos tienen un motor más grande en cuanto a 
#capacidad de combustible que un suv (utilitario común familiar) ya que están
#mucho más a la derecha, incluso también más que las furgonetas pickup, pero
#también tiene un cuerpo más pequeño que un compacto o un midsize, lo que hace que 
#compense el tener un motor grande y ser más ergónomico, aereodinámico para
#obtener un número de millas más alto por unidad de galón. Por tanto, estos 
#coches parece ser que cumplen las expectativas y cuadran con los datos que teníamos.

#También podríamos haber mapeado la clase a la estética del tamaño de los puntos:
# (conviene que sea numérico)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#Ahora podríamos utilizar la estética de alpha que controle la transparencia
#de los puntos.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# A continuación vamos a utilizar la estética de la forma de los puntos.
#(solo permite 6 formas a la vez).

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#Además podemos elegir de forma manual la estética.
#Estética global:fuera del mapping

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), color = "red")
#color = nombre del color en formato string
#size = tamaño del punto en mm
#shape = forma del punto con números desde el 0 al 25.
# 0 - 14: son formas huecas y por tanto sólo se le puede cambiar el color.
# 15 - 20: son formas rellenas de color, por tanto se le puede cambiar el color.
# 21 - 25: son formas con borde y relleno, y se les puede cambiar el color (borde)
# y el fill (relleno).

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy),
             shape = 23, size = 10, color = "red",
             fill = "yellow")


## FACETS: Dividir el plot en subplots, cada una correspondiente a una categoría.
# facet_wrap(~<FORMULA_VARIABLE>): La variable debe ser discreta categórica. Realiza un
#gráfico para cada categoría.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) + #Representacion de los datos
  facet_wrap(~class, nrow = 3) #Distribución, segmentación segun una variable.

# facet_grid(<FORMULA_VARIABLE1>~<FORMULA_VARIABLE2>) Para combinar dos
# variables categóricas.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(.~cyl)


# OBJETO GEOMÉTRICO:
# Es lo que se utiliza en ggplot2 para representar visualmente el dato.

# Diferentes geometrías:

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy,  color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv))



ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy ,group = drv, color = drv))

ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv, color = drv),
              show.legend = T)
# Estamos forzando que nos aparezca la leyenda con el argumento show.legend


ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x= displ, y = hwy))

# En el código anterior estamos aplicando dos geometrías, pero el problema
#que existe es que se repite el mapping en ambos casos, y si queremos cambiar
#por ejemplo, la variable y tendríamos que hacerlo en cada geometría y se nos
#podría olvidar en alguna y la liamos. Por esta razón, la estética se suele
# introducir en el ggplot para que sea globales para todas las geometrías.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(shape = class)) +
  geom_smooth(mapping = aes(color = drv))


#Además, podemos realizar una geometría sobre un subconjunto de los datos.
# Cada geometría puede tener su propio mapping (local) y siempre prevalecerá al 
#mapping global.

ggplot(data = mpg, mapping = aes( x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "suv"), se = F)

#se: Elimina el intervalo de confianza.




# Ejemplo del dataset de diamantes----

View(diamonds)
?diamonds
# carat: El peso del diamante(en kilates)
# cut: Calidad de corte del diamante (Regular, Bueno, Muy bueno, Premium, Ideal)
# color: El color del diamante, desde D (el mejor) hasta J (el peor).
# clarity: Una medida de la claridad del diamante (I1 (peor), SI2, SI1, 
# VS2, VS1, VVS2, VVS1, IF (mejor))
# depth: Porcentaje total de profundidad
# table: Anchura de la parte superior del diamante en relación con el punto 
# más ancho
# price: El precio del diamante en dólares
# x, y, z: longitud, anchura y profundidad del diamente en milimétros.

## Diagrama de barras ----

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

?geom_bar
# Utiliza la función stat_count() que cuenta el nº de casos para cada categoría.

ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))

#Esta transformación funciona porque toda la geometria tiene por defecto un stat.
# Todos los stat se corresponden a una geometría por defecto.Por tanto, podemos
# usar la geometría sin preocuparnos de las transformación estadísticas(stat) 
#subyacentes.


demo_diamonds <- tribble(
  ~cut,       ~freqs,
  "Fair",       1610,
  "Good",       4906,
  "Very Good", 12082,
  "Premium",   13791,
  "Ideal",     21551
)

# Nº de casos:
ggplot(data = demo_diamonds) +
  geom_bar(mapping = aes(x = cut, y = freqs),
           stat = "identity" )

# Proporción de casos:

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1)) 
#group = 1: Para que haya una agrupación por filas, es decir, agrupación 
# de las x. La suma debe dar 1.

ggplot(data = diamonds) +
  stat_summary(mapping = aes(x = cut, y = depth),
               fun.min = min,
               fun.max = max,
               fun = median)
# Estamos representando el min, max y mediana de la profundidad para cada 
#clase de corte.

# Resumen estadístico:
ggplot(data = diamonds) +
  stat_summary(mapping = aes(x = cut, y = price),
               fun.min = min,
               fun.max = max,
               fun = mean)
# Vemos que no hay mucha diferencia de precio entre calidades del diamante.


# Colores y formas de los gráficos:

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

# Diagrama de barras apilado: apila las barras
# position = stack 
ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, fill = color))

ggplot(data = diamonds)+
  geom_bar(mapping = aes(x = cut, fill = clarity))

## position = "identity": se suporponen las barras

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity))+
  geom_bar(position = "identity", alpha = 0.2)

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity))+
  geom_bar(position = "identity", fill = NA)

## position = "fill": para comparar proporciones

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity))+
  geom_bar(position = "fill")

## position = "dodge":para cada categoria tiene un diagrama de barras

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity))+
  geom_bar(position = "dodge")


# Volvemos al scatterplot: No pinta todos los puntos ya que se redondean
#los valores de hwy y displ por lo que hay puntos que se suponerponen.
# A este problema se le denonima OVERPLOTTING. No podemos ver la concentración
# de los vehiculos.

#position = "jitter": Añade ruido a los puntos.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(position = "jitter")

# Realmente se utiliza:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_jitter()

?position_stack
?position_identity
?position_fill
?position_dodge
?position_jitter


# Sistemas de Coordenadas ----

# coord_flip() -> cambia los papeles de x e y flip:girar.
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip()

# BOXPLOT: Entre 1 cuartil y la mediana hay un 25% de los datos y entre la mediana y
# el 3 cuartil hay un 25 % de los datos. Por tanto en la caja cae entre el 25 y 75%
# de los datos.


# coord_quickmap() -> configura el aspect ratio para mapas

usa <- map_data("usa")

ggplot(usa, mapping = aes(long,lat, group = group)) +
  geom_polygon(fill = "blue", color = "white") +
  coord_quickmap()

italy <- map_data("italy")

ggplot(italy, mapping = aes(long,lat, group = group)) +
  geom_polygon(fill = "blue", color = "white") +
  coord_quickmap()


# coord_polar() -> coordenadas polares

ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = F,
    width = 1
  ) +
  theme(aspect.ratio = 1) + # el gráfico es completamente cuadrado
  labs(x = NULL, y = NULL) +
  coord_polar()

