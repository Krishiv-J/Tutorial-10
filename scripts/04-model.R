#### Preamble ####
# Purpose: Models the 
# Author: Krishiv Jain
# Date: 17/03/24
# Contact: krishiv.jain@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(dplyr)

#### Read data ####
analysis_data <- read_csv("data/analysis_data/cleaned_data.csv")

### Model data ####

# From https://tellingstorieswithdata.com/13-ijaglm.html

model <- 
  glm(goals_conceded ~ away_attacking_strength + away_defending_strength,
      data = analysis_data, family = "poisson")

summary(model)

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

analysis_data <- mutate(analysis_data, predicted_goals = predict(model, newdata = analysis_data, type = "response"))

