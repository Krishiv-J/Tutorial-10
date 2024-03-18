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
raw_data <- read_excel("data/raw_data/Essay 10 Raw Data.xlsx")

home_data <- read_excel("data/raw_data/Essay 10 Raw Data.xlsx", sheet = "Home - For")

home_data <- home_data |>
  rename(Home_Scored = `Goals Scored`)

second_col <- read_excel("data/raw_data/Essay 10 Raw Data.xlsx", sheet = "Home - Against")
home_data$Home_Conceded <- second_col$`Goals Conceded`



away_data <- read_excel("data/raw_data/Essay 10 Raw Data.xlsx", sheet = "Away - For")

away_data <- away_data |>
  rename(Away_Scored = `Goals Scored`)

second_col <- read_excel("data/raw_data/Essay 10 Raw Data.xlsx", sheet = "Away - Against")
away_data$Away_Conceded <- second_col$`Goals Conceded`

## Finding Each Team's Averages ##

### Home 

home_data$scored_average <- home_data$Home_Scored/19
home_data$conceded_average <- home_data$Home_Conceded/19


### Away 

away_data$scored_average <- away_data$Away_Scored/19
away_data$conceded_average <- away_data$Away_Conceded/19


## Finding League's Averages ##

a <- mean(home_data$scored_average)
b <- mean(home_data$conceded_average)

c <- mean(away_data$scored_average)
d <- mean(away_data$conceded_average)

## Finding Teams' Strengths ##

home_data$home_attacking_strength <- home_data$scored_average/a
home_data$home_defending_strength <- home_data$conceded_average/b

away_data$attacking_strength <- away_data$scored_average/a
away_data$defending_strength <- away_data$conceded_average/b

## Combined Table ##

home_data$Home_Scored <- NULL
home_data$Home_Conceded <- NULL
home_data$scored_average <- NULL
home_data$scored_average <- NULL
home_data$conceded_average <- NULL
home_data$away_attacking_strength <- away_data$attacking_strength
home_data$away_defending_strength <- away_data$defending_strength


#### Save data ####
write_csv(home_data, "data/analysis_data/cleaned_data.csv")