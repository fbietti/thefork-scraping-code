library(dplyr)
library(tidyr)
library(stringr)
library(questionr)


# To begin with, we declare the database.
pizzerias <- read.csv2("pizza.csv", sep = ',', header = T)


# We clean the address to extract the district number and create a new column for it
pizzerias <-pizzerias %>% extract(Adresse, c('Rue', 'Arr', 'ville'), "([^,]+), ([^)]+), ([^)]+)")
pizzerias <- pizzerias[,-c(3,5)]
pizzerias$Arr = as.numeric(gsub(".*?([0-9]+).*", "\\1", pizzerias$Arr))
class(pizzerias$Arr)
freq(pizzerias$Arr)

match(c(1,2,7,11,12,96), pizzerias$Arr)

# We remove duplicates or incomplete observations.
pizzerias <-pizzerias[-c(687,1776,1955,2321,1714,1308),]

# We replace 75116 with 75016 to standardize the database
pizzerias$Arr[pizzerias$Arr == 75116] <- 75016

# We convert the DataFrame to a CSV file.
write.csv(pizzerias, "pizza.csv", row.names=FALSE)

