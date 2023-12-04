
library(dplyr) # Package for data manipulation
library(sf) # Package for working with spatial data
library(ggplot2) # Package for creating plots

# Read in shapefile
lsoa21_sf <- st_read("data/Lower_layer_Super_Output_Areas_2021_EW_BFC_V8_8154990398368723939/LSOA_2021_EW_BFC_V8.shp")

# Read in data
emp21 <- read.csv("data/2021lsoa_econ_act_manchester.csv",
                  skip = 9)

# Join data with shapefile
emp21_sf <- inner_join(lsoa21_sf,                       
                       emp21, 
                       by = c("LSOA21CD" = "mnemonic"))

# Preprocess data - create new variable for % economically inactive
emp21_rate <- mutate(emp21_sf, 
                     ec_inact_perc = Economically.inactive..excluding.full.time.students./Total*100)

# Plot data
ggplot(emp21_rate, aes(fill = ec_inact_perc)) +
  geom_sf()



