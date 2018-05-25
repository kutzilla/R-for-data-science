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
