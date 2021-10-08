
# Template for making a graphical representation with ggplot2 ----

# ggplot(data = <DATA_FRAME>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


# Aesthetics ggplot2 ----

  # Color of the points---- 

# ggplot(<DATA_FRAME>) + 
#   geom_point(mapping = aes(x = <VAR_X>, y = <VAR_Y>, color = <VAR_COLOR>))


  # Size of the points (It should be numeric) ----

# ggplot(<DATA_FRAME>) + 
#   geom_point(mapping = aes(x = <VAR_X>, y = <VAR_Y>, size = <VAR_SIZE>))


  # Transparency of the points ----

# ggplot(<DATA_FRAME>) + 
#   geom_point(mapping = aes(x = <VAR_X>, y = <VAR_Y>, alpha = <VAR_ALPHA>))


  # Shape of the points (allows only 6 shape at a time) ----

# ggplot(<DATA_FRAME>) + 
#   geom_point(mapping = aes(x = <VAR_X>, y = <VAR_Y>, shape = <VAR_SHAPE>))


# Aesthetics global ggplot2 (Out of the mapping) ----

# ggplot(<DATA_FRAME>)+
    # geom_point(mapping = aes(x = <VAR_X>, y = <VAR_Y>),
    #        shape = 23, size = 10, color = "red",
    #        fill = "yellow")

# color = color name in string format.
# size = size of the point in mm.
# shape = shape of the point with numbers from 0 to 25.
  # 0 - 14: are hollow shapes and therefore only the color can be changed.
  # 15 - 20: are shapes filled with color, so you can change the color.
  # 21 - 25: are shapes with border and fill, and you can change the 
  # color (border) and fill (fill).

d=data.frame(p=c(0:25))
ggplot() +
  scale_y_continuous(name="") +
  scale_x_continuous(name="") +
  scale_shape_identity() +
  geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red") +
  geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)

