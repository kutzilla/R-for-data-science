library(nycflights13)
library(tidyverse)

# Ausgabe der Spalten und Daten vom Dataset flights
flights

# Ansehen der Daten in RStudio
View(flights)

# Filtern von Zeilen
filter(flights, month == 1, day == 1)

# Speichern der gefilterten Zeilen in einem neuen Dataframe
jan1 <- filter(flights, month == 1, day == 1)

# Speichern und Ausgabe eines neuen Dataframes
(dec25 <- filter(flights, month == 12, day == 25))

# Vergleich von Gleitpunktzahlen mit und ohne die near-Funktion
sqrt(2) ^ 2 == 2
1 / 49 * 49 == 1

near(sqrt(2) ^ 2, 2)
near(1 / 49 * 49, 1)

# Flüge aus November & Dezember mit Oder-Operator
filter(flights, month == 11 | month == 12)

# Filter mit x %in% y Shorthand
nov_dec <- filter(flights, month %in% c(11, 12))

# De Morgan's Gesetz. Beide Abfrage führen zum identischen Ergebnis
filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# Fehlende Werte
NA > 5
10 == NA
NA + 10
NA / 2
NA == NA

x <- NA
is.na(x)

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)
