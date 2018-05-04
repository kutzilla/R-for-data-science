# Install tidyverse
install.packages("tidyverse")

# Verwenden von tidyverse
library(tidyverse)

# Installation von Data Packages
install.packages(c("nycflights13", "gapminder", "Lahman"))

# Setzen der Systemsprache auf Englisch
Sys.setenv(LANGUAGE = "en")

# Checken von Updates für das Package tidyverse
tidyverse_update()

# Generieren von R-Code zur Reproduktion des Datasets "mtcars"
dput(mtcars)