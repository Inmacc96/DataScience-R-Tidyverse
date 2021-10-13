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
#Cada geometría puede tener su propio mapping (local) y siempre prevalecerá al mapping
#global.

ggplot(data = mpg, mapping = aes( x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "suv"), se = F)

#se: Elimina el intervalo de confianza.