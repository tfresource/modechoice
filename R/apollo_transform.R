library(apollo)
library(tidyverse)

# Munge data into "wide" format required by apollo =========
data("TravelMode", package = "AER")
database <- left_join(
  # get the choice and the generic variables
  TravelMode %>% tibble() %>%
    mutate(mode = as.character(mode),
           choice = ifelse(choice == "yes", mode, NA)) %>%
    group_by(individual) %>%
    summarise(choice = mode[!is.na(choice)], income = income[1], size = size[1]),
  # pivot into wider
  TravelMode %>% tibble() %>%
    pivot_wider(id_cols = individual, names_from = mode, values_from  = c(wait, vcost, travel, gcost)),
  by = "individual"
) %>%
  rename(ID = individual) %>%
  mutate(ID = as.character(ID))

## Configure apollo run =========
apollo_initialise()
apollo_control <- list(
  modelName = "MyModel",
  modelDescr = "Basic",
  indivID = "ID"
)

choiceAnalysis_settings <- list(
  alternatives = c(car = "car", bus = "bus", air = "air", train = "train"),
  choiceVar = database$choice,
  avail = 1,
  explanators = database[, c("income", "size")],
  rows = rep(TRUE, nrow(database))
)

# create parameters
apollo_beta <- c(
  asc_car = 0, asc_bus = 0, asc_train = 0, asc_air = 0,
  b_size_bus = 0, b_size_train = 0, b_size_air = 0,
  b_wait = 0,
  b_vcost= 0
)
apollo_fixed = c("asc_car")
apollo_inputs <- apollo_validateInputs(silent = TRUE)


# MNL likelihood function ====================-
apollo_probabilities <- function(apollo_beta, apollo_inputs, functionality = "estimate"){
  
  ### Attach inputs and detach after function exit
  apollo_attach(apollo_beta, apollo_inputs)
  on.exit(apollo_detach(apollo_beta, apollo_inputs))
  
  ### Create list of probabilities P
  P = list()
  
  ### List of utilities: these must use the same names as in mnl_settings, order is irrelevant
  V = list()
  V[['car']]   = asc_car   + b_wait * wait_car   + b_vcost * vcost_car   
  V[['bus']]   = asc_bus   + b_wait * wait_bus   + b_vcost * vcost_bus   + b_size_bus * size
  V[['air']]   = asc_air   + b_wait * wait_air   + b_vcost * vcost_air   + b_size_air * size
  V[['train']] = asc_train + b_wait * wait_train + b_vcost * vcost_train + b_size_train * size
  
  ### Define settings for MNL model component
  mnl_settings = list(
    alternatives = c(car = "car", bus = "bus", air = "air", train = "train"),
    avail         = 1,
    choiceVar     = choice,
    V             = V
  )
  
  ### Compute probabilities using MNL model
  P[['model']] = apollo_mnl(mnl_settings, functionality)
  
  ## SHOULDN'T NEED TO DO PANEL MULTIPLICATION: ONE ROW PER OBSERVATION
  
  ### Prepare and return outputs of function
  P = apollo_prepareProb(P, apollo_inputs, functionality)
  return(P)
}

model = apollo_estimate(apollo_beta, apollo_fixed, apollo_probabilities, apollo_inputs)

## Error in apollo_prepareProb(P, apollo_inputs, functionality) : 
##  Need to multiply observations for the same individual! (see ?apollo_panelProd)