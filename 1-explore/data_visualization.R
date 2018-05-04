# Laden von tidyverse
library(tidyverse)

# Darstellung von der Motorgröße (x-Achse) und Benzinverbrauch (y-Achse)
# eines Fahrzeugs aus dem mpg-Dataset
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))

# Wiederverwendbares Template für ggplot: 
# ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

ggplot(data = mpg)

# Informationen zu dem Dataset mpg
?mpg

# Plot zwischen der Zylinderanzahl (cyl) und Benzinverbrauch (hwy) eines Fahrzeugs
ggplot(data = mpg) + geom_point(mapping = aes(x = cyl, y = hwy))

# Plot zwischen der Fahrzeugklasse (class) und der Antriebsart (drv)
# Nicht hilfreich aufgrund der Punktdarstellung
ggplot(data = mpg) + geom_point(mapping = aes(x  = class, y = drv))

# Plot zwischen der Motorgröße (displ), Benzinverbrauch (hwy) und Klasse (class) als Farbe
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Plot zwischen der Motorgröße (displ), Benzinverbrauch (hwy) und Klasse (class) als Größe.
# Verwendung von Größe als "Ästhetik" für diskrete Werte allerdings ungeeignet.
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, size = class))

# Gleicher Plot mit Transparenz als "Ästhetik"
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Gleicher Plot mit Form als "Ästhetik". Allerdings werden nur 6 verschiedenen Formen dargstellt.
# SUVs haben in diesem Plot keine Form.
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# Gleicher Plot mit allen Punkten in Blau.
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# Plot aus Klasse (x = class), Benzinverbrauch (y = hwy) und die Motorgröße (displ) als Farbe
ggplot(data = mpg) + geom_point(mapping = aes(x = class, y = hwy, size = displ))

# Erstellung eines Scatterplot mit Subplot ("Faceten") für die Fahrzeugkategorien
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_wrap(~ class, nrow = 2)

# Erstellung eines Plots mit 4 Variablen durch Facets
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + facet_grid(drv ~ cyl)


## Darstellung der gleichen Daten einmal mit Point und einmal mit Smooth Geom

# Point Geom
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy))
# Smooth Geom
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))

