# load libraries
library(tidyverse)
library(here)

# Import 1952-1967 data
## gdp data
gdp.data.1952_1967 <- read.csv(here("build", "inputs", "gdp_52-67.csv"))
## Life expectancy data
lifeExp.data.1952_1967 <- read.csv(here("build", "inputs", "le_52-67.csv"))

# Combine data
data.1952_1967 <- gdp.data.1952_1967 %>%
  left_join(lifeExp.data.1952_1967, by = c("continent", "country", "year"))

# Calculate gdp per capita and name it gdpPercap
data.1952_1967 <- data.1952_1967 %>%
  mutate(gdpPercap = gdp/pop)

# Write data to csv
write.csv(data.1952_1967, file = here("analysis", "input", "combined_52-67.csv"))
