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

# Filter mit NA-Werten
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

# Änderung der Reihenfolge des Dataframes mit arrange
arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))

# NA Werte werden mit arrange am Ende sortiert
df <- tibble(x = c(5, 2, NA))
arrange(df, x)
arrange(df, desc(x))

# Auswahl von Subsets mit select-Funktion
select(flights, year, month, day)

# Auswahl aller Spalten zwischen den genannten
select(flights, year:day)

# Auswahl aller Spalten außer die zwischen den genannten Spalten
select(flights, -(year:day))

# Umbennenung einer Spalte mit der rename-Funktion
rename(flights, tail_num = tailnum)

# Select mit dem everything-Helper um Spalten nach vor
select(flights, time_hour, air_time, everything())

# Hinzufügen von Variablen mit mutate
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours)

# Erzeugen neuer Variablen und nur Erhaltung dieser mit transmute
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
          )
# Modulo-Operatoren zur Erzeugung von Variablen
transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

# Offsets mit lag and lead
(x <- 1:10)
lag(x)
lead(x)

# Kummulative Werte
cumsum(x)
cummean(x)

# Ranking der Werte
y <- c(1, 2, 2, NA, 3, 4)
min_rank(y)
min_rank(desc(y))
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

# Gruppierte Zusammenfassungen mit summarize
summarize(flights, delay = mean(dep_delay, na.rm = TRUE))

# Gruppierung mit group_by und summarize
by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

# Kombination von mehreren Operationen mit einer Pipe
delays <- flights %>% group_by(dest) %>% summarize(count = n(),
                                                   dist = mean(distance, na.rm = TRUE),
                                                   delay = mean(arr_delay, na.rm = TRUE)
                                                   ) %>%
  filter(count > 20, dest != "HNL")

# Filtern von gecancelten Flügen
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

# Zählen mit der count-Funktion n()
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay)
  )
ggplot(data = delays, mapping = aes(x = delay)) + geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

delays %>%
  filter(n > 25) %>%
  ggplot(mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

batting <- as_tibble(Lahman::Batting)

batters <- batting %>%
  group_by(playerID) %>%
  summarize(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>%
  filter(ab > 100) %>%
  ggplot(mapping = aes(x = ab, y = ba)) +
    geom_point() +
    geom_smooth(se = FALSE)

batters %>%
  arrange(desc(ba))

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    # Durchschnittlicher Verzögerung
    avg_delay1 = mean(arr_delay),
    # Durchschnittliche positive Verzögerung
    avg_delay1 = mean(arr_delay[arr_delay > 0])
  )

# Standardabweichung sd
not_cancelled %>%
  group_by(dest) %>%
  summarize(distance_sd = sd(distance)) %>%
  arrange(desc(distance_sd))

# Ränge in Datasets mit max und min
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    first = max(dep_time),
    last = min(dep_time)
  )

# Positionen in Datasets mit first und last
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )

# Filtern mit range
not_cancelled %>%
  group_by(year, month, day) %>%
  mutate(r = min_rank(desc(dep_time))) %>%
  filter(r %in% range(r))

# Zählen der einzigartigen Werte mit n_distinct
not_cancelled %>%
  group_by(dest) %>%
  summarize(carriers = n_distinct(carrier)) %>%
  arrange(desc(carriers))

# Zählen mit counts
not_cancelled %>% 
  count(dest)

# Nutzen von count um Gesamtmeilen zu bestimmen
not_cancelled %>% 
  count(tailnum, wt = distance)

# sum und mean wandeln logische Operationen in Zahlen um (TRUE = 1, FASLE = 0)
not_cancelled %>%
  group_by(year, month, day) %>% 
  summarize(n_early = sum(dep_time < 500))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(hour_perc = mean(arr_delay > 60))

# Gruppiern mit mehreren Variablen
daily <- group_by(flights, year, month, day)

(per_day <- summarize(daily, flights = n()))
(per_month <- summarize(per_day, flights = sum(flights)))
(per_year <- summarize(per_month, flights = sum(flights)))

# Trennen von Gruppen mit ungroup
daily %>% 
  ungroup() %>% 
  summarize(flights = n())

# Gruppierte Mutates und Filter
flights_sml %>% 
  group_by(year, month, day) %>% 
  filter(rank(desc(arr_delay)) < 10)

popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)
popular_dests

popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)
