#### Preamble ####
# Purpose: Downloads and saves the data
# Author: Krishiv Jain
# Date: 17/03/24
# Contact: krishiv.jain@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(readxl)
library(dplyr)


#### Clean data ####
raw_data <- read_excel("data/raw_data/Tutorial 10 Raw Data.xlsx")

clean_data <- read_excel("data/raw_data/Tutorial 10 Raw Data.xlsx", sheet = "Defensive - Home")

clean_data <- clean_data |>
  rename(Defensive_Home = Rating)

second_col <- read_excel("data/raw_data/Tutorial 10 Raw Data.xlsx", sheet = "Defensive - Away")
clean_data$Defensive_Away <- second_col$Rating

third_col <- read_excel("data/raw_data/Tutorial 10 Raw Data.xlsx", sheet = "Attack - Home")
clean_data$Attack_Home <- third_col$Rating

fourth_col <- read_excel("data/raw_data/Tutorial 10 Raw Data.xlsx", sheet = "Attack - Away")
clean_data$Attack_Away <- fourth_col$Rating

#### Save data ####
write_csv(clean_data, "data/analysis_data/cleaned_data.csv")
