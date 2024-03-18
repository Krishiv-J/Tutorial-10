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

old_trafford_model <- 
  glm(old_trafford_goals_conceded ~ away_attacking_strength + away_defending_strength,
      data = analysis_data, family = "poisson")

summary(old_trafford_model)

away_model <- 
  glm(at_home_goals_conceded ~ home_attacking_strength + home_defending_strength,
      data = analysis_data, family = "poisson")

summary(away_model)

#### Save model ####
saveRDS(
  old_trafford_model,
  file = "models/home_model.rds"
)

saveRDS(
  away_model,
  file = "models/away_model.rds"
)

predicted_home_goals <- predict(old_trafford_model, newdata = analysis_data, type = "response")
predicted_away_goals <- predict(away_model, newdata = analysis_data, type = "response")

combined_data <- cbind(predicted_home_goals, predicted_away_goals)

