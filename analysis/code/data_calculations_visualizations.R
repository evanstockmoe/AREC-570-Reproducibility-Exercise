# Load libraries
library(tidyverse)
library(here)
library(stargazer)

# Load organized data set
data.1952_1967 <- read.csv(here("analysis", "input", "combined_52-67.csv"))

# Create line plot of life expectancy over time for Canada in the 1950s and 1960s
life.52_67.plot <- data.1952_1967 %>%
  filter(country == "Canada")%>%
  ggplot(aes(x = year, y = lifeExp)) +
  geom_line() +
  labs(title = "Life Expectancy in Canada (1952-1967)",
             x = "Year",
             y = "Life Expectancy")

# Save the plot
ggsave(filename = "Life_Expectancy_Canada_1952_1967.pdf", path = here("analysis", "output"), 
       plot = life.52_67.plot, width = 5, height = 3, units = "in")

# Create line plot of GDP per capita over time for Canada in the 1950s and 1960s
gdp.52_67.plot <- data.1952_1967 %>%
  filter(country == "Canada")%>%
  ggplot(aes(x = year, y = gdpPercap)) +
  geom_line() +
  labs(title = "GDP per Capita in Canada (1952-1967)",
       x = "Year",
       y = "GDP per Capita")

# Save the plot
ggsave(filename = "GDP_Per_Capita_Canada_1952_1967.pdf", path = here("analysis", "output"), 
       plot = gdp.52_67.plot, width = 5, height = 3, units = "in")

# Regress life expectancy on gdp per capita
regression_lifeExp_gdpPercap <- lm(lifeExp ~ gdpPercap, data = data.1952_1967)

# Create a summary table table written in latex
regression_summary <- stargazer(regression_lifeExp_gdpPercap, type = "latex", title = "Life expetancy on GDP per capita")

# Create file for latex code to be saved to
file_path <- here("analysis", "output", "regression_summary.tex")

# Write the LaTeX code to the file
writeLines(regression_summary, con = file_path)
