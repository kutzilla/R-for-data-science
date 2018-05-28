library(tidyverse)

# Gleiche Daten als Plot und DataFrame
ggplot(data = diamonds) + geom_bar(mapping = aes(x = cut))
diamonds %>% count(cut)

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)
diamonds %>% count(cut_width(carat, 0.5))

# Veränderung des Informationsgrades durch Änderung der Balkenbreite
smaller <- diamonds %>% 
  filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

# Verwendung von freqpoly statt histogram um Veränderungen als Linien 
# und um mehrere Histogramme übereinander darzustellen
ggplot(data = smaller, mapping = aes(x = carat, color = cut)) + geom_freqpoly(binwidth = 0.1)

ggplot(data = smaller, mapping = aes(x = carat)) + geom_histogram(binwidth = 0.01)

ggplot(data = faithful, mapping = aes(x = eruptions)) + geom_histogram(binwidth = 0.25)

# Untersuchung von Ausreißern. Zoom mit coord_cartesian
ggplot(diamonds) + geom_histogram(aes(x = y), binwidth = 0.5)

ggplot(diamonds) + geom_histogram(aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  arrange(y)
unusual

# Entfernen von Datensätzen mit ungewöhnlichen Werten
diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))

# Ersetzen von unüblichen Werten mit NA
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

# Warnung von ggplot bzgl. fehlender Werte
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + geom_point() 
# Verhinderung der Warnung
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) + geom_point(na.rm = TRUE)

nycflights13::flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(mapping = aes(sched_dep_time)) +
  geom_freqpoly(
    mapping = aes(color = cancelled),
    binwidth = 1/4
  )

# Anscheinend sind die Diamanten mit der niedrigsten Qualität die teuersten
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)
# Überprüfung dieser Hyptothese durch einen Boxplot
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) + geom_boxplot()

# Weiterer Boxplot
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot()
# Änderung der Reihenfolge der Boxen
ggplot(data = mpg) +
  geom_boxplot(
    mapping = aes(
      x = reorder(class, hwy, FUN = median),
      y = hwy)
  )
# Drehen des Boxplots
ggplot(data = mpg) +
  geom_boxplot(
    mapping = aes(
      x = reorder(class, hwy, FUN = median),
      y = hwy)
  ) +
  coord_flip()

# Zählen der Kombinationen zwischen cut und color mit ggplot
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))
# Zählen mit dplyr
diamonds %>% 
  count(color, cut) %>% 
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))

# Darstellung der Kovarianz als Scatterplot
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price),
             alpha = 1 / 100)

# Verwendung von bin2d und hex für eine bessere Darstellung der Mengen
ggplot(data = smaller) +
  geom_bin2d(mapping = aes(x = carat, y = price))
ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price))

# Verwendung von Bin für eine kontinurierliche Variable
ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
# Darstellung der Menge an Datensätzen anhand der Breite des Boxplots
ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_number(carat, 20)))

# Darstellung von Mustern (2 Cluster)
ggplot(data = faithful) +
  geom_point(mapping = aes(x = eruptions, y = waiting))

# Erzeugung von Modellen aus kausalen Mustern
library(modelr)

# Modell zur Vorhersage des Preises durch Karat
mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

ggplot(data = diamonds2) +
  geom_point(mapping = aes(x = carat, y = resid))

# Erkennung des Zusammenhangs zwischen Preis und Qualität nach Entfernen von Cut
ggplot(data = diamonds2) +
  geom_boxplot(mapping = aes(x = cut, y = resid))

# Abkürzung von ggplot-Aufrufen
ggplot(faithful, aes(eruptions)) +
  geom_freqpoly(binwidth= 0.25)

# Plot mit Bearbeitung von Daten
diamonds %>% 
  count(cut, clarity) %>% 
  ggplot(aes(clarity, cut, fill = n)) +
  geom_tile()
