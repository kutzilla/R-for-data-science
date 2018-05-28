# Ausgabe des aktuellen Work Directories
getwd()

# Setzen des Work Directories
setwd("C:/Users/b74/Documents/R-for-data-science")

# Erzeugen einer PDF- und CSV-Datei aus Plot und Daten
library(tidyverse)

ggplot(diamonds, aes(carat, price)) +
  geom_hex()
ggsave("diamonds.pdf")

write_csv(diamonds, "diamonds.csv")