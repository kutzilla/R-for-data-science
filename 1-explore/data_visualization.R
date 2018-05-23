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

# Smooth Geom mit einzelnen unterschiedlichen Linien für die Antriebsarten
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy, color = drv))

# Mehrere Geoms in einem Plot
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + geom_smooth(mapping = aes(x = displ, y = hwy))

# Mehrere Geoms in einem Plot ohne doppelten Code
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_smooth() + geom_point()

# Mehrere Geoms in einem Plot ohne doppelten Code und einzelnen Schichten-Ästhetiken
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point(mapping = aes(color = class)) + geom_smooth() 

# Überschreiben des globalen ggplot-Datenargument innerhalb von geom_smooth
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  )

# Darstellung von Diamanten nach ihrer Qualität als Balkendiagramm
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))


# Erzeugung des demo Datensets
demo <- tribble(
  ~a,       ~b,
  "bar_1",  20,
  "bar_2",  30,
  "bar_3",  40
  )

# Plot eines Barcharts aus den x, y Werten von demo mithilfe der identity-Funktion
ggplot(data = demo) +
  geom_bar(
    mapping = aes(x = a, y = b), stat = "identity"
  )

# Darstellung des proportionalen Verhältnisses zwischen der Diamant-Qualität als Balkendiagramm
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

# Balkendiagramm mit Füllung
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = cut))

# Balkendiagramm mit gestapelter Füllung
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity))

# Balkendiagramm mit Alphawert für Transparenz
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")

# Balkendiagramm mit völliger Transparenz
ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) +
  geom_bar(fill = NA, position = "identity")

# Balkendiagramm mit gleicher Höhe aller Balken durch position "fill"
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

# Balkendiagramm mit einzelnen Balken für die Werte durch position "dodge"
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# Scatterplot mit Attribut position "jitter" um überlappende Punkte sichtbar zu machen
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

# Klassischer Boxplot
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot()

# Boxplot mit gedrehtem Koordinatensystem
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot() + coord_flip()

# Speichern der Kartendaten von Neuseeland
require(maps)
nz <- map_data("nz")

# Plot von Neuseeland
ggplot(nz, aes(long, lat, group = group)) + geom_polygon(fill = "white", color = "black")

# Einsatz von quickmap passendes Seitenverhältnis von Karten
ggplot(nz, aes(long, lat, group = group)) + geom_polygon(fill = "white", color = "black") + coord_quickmap()

# Erzeugung eines Bar-Charts
bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

# Bar-Chart mit gedrehtem Koordinatensystem
bar + coord_flip()
# Bar-Chart mit Polarkoordinaten
bar + coord_polar()
