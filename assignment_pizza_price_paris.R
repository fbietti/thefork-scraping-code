library(ggplot2)
library(dplyr)
library(tidyverse)
library(questionr)


pizzerias <- read.csv2('./pizzerias.csv', sep = ',') # upload the dataset... I have it in my pc

## 1) Test the types of the Prices and Arr variables
class(pizzerias$Arr)
class(pizzerias$Prices)

## 2) Change the type of the Arr variable. First, make this variable a character variable, and then make it a factor variable.
# pizzerias$Arr <- as.factor(as.character(pizzerias$Arr))
# pizzerias$Prices <- as.factor(as.character(pizzerias$Prices))

### 3) What is the average price of pizzerias in Paris?
mean(pizzerias$Prices)

### 4) Use a function to find the min, max, and quantiles of prices for pizzerias in Paris
summary(pizzerias$Prices)

## 5) Find the index, name, and price of the cheapest pizzeria in Paris
order(pizzerias$Prices)
pizzerias[2498,]

## 6) Find the index, name, and price of the most expensive pizzeria in Paris
order(pizzerias$Prices, decreasing = TRUE)
pizzerias[695,]

## 7) Find the index, price, and district of the I Diavoletti pizzeria
match('I Diavoletti', pizzerias$Pizzeria)

## 8) What is the district with the most pizzerias in Paris?
table(pizzerias$Arr)

## 9) What is the district with the fewest pizzerias in Paris?
table(pizzerias$Arr)

class(pizzerias$Arr)

pizzerias$Arr <- as.character(pizzerias$Arr)

### 10) Bivariate analysis.

### The dependent variable is Price. We want to know if the district explains the price of pizza in Paris.
###  
## a) Formulate a hypothesis explaining the potential link between the Arr (district) and Price variables.

### Certainly! Here's the translated paragraph in English:

## The prices of products are often stratified based on the city, neighborhood, and consumer profile. Consequently, we expect to observe a variation in prices across the neighborhoods of Paris. Paris is a heterogeneous city, meaning that we find popular neighborhoods, middle-class neighborhoods, tourist districts, and affluent neighborhoods. This heterogeneity will also be reflected in pizza prices. Thus, we anticipate seeing that in popular neighborhoods, the price of pizza is lower than in other areas. We also expect to see that in tourist districts and affluent neighborhoods, the price of pizza is higher.
## b) The dependent variable, Price, is a quantitative (numeric) variable. Using the case_when function, recode the variable into 3 categories: "1. Normal", "2. Expensive", "3. Very expensive". Name the new variable Price_r. To do this:

### First, look at the distribution of the variable with the summary() function. Then, create a histogram to have a graphical representation of the variable to find the criteria for your recoding.
###

summary(pizzerias$Prices)
hist(pizzerias$Prices)

pizzerias$Prices_r <- case_when(
  pizzerias$Prices < 30 ~ "1. Cheap",
  pizzerias$Prices >= 30 & pizzerias$Prices <= 70 ~ "2. Expensive",
  TRUE ~ "3. Very Expensive"
)

table(pizzerias$Prices_r)

## c) The independent variable, Arr, is a factor variable (you did this for question 2). Using the case_when function, recode the variable as follows: 
### 75001, 75002, 75003, 75004  ~ '1.Tourist districts'
###  75005, 75006 ~ '2.Latin Quarter'
###  75007, 75008, 75016 ~ '3.Affluent districts'
###  75009, 75010, 75011, 75012, 75013 ~ '4.Normal districts'
###  75014, 75015, 75017 ~ '5.Family districts'
###  75018, 75019, 75020 ~ '6.Popular districts'

pizzerias$Arr_r <- case_when(
  pizzerias$Arr %in% c(75001, 75002, 75003, 75004) ~ "1.Tourist districts",
  pizzerias$Arr %in% c(75005, 75006) ~ "2.Latin Quarter",
  pizzerias$Arr %in% c(75007, 75008, 75016) ~ "3.Affluent districts",
  pizzerias$Arr %in% c(75009, 75010, 75011, 75012, 75013) ~ "4.Normal districts",
  pizzerias$Arr %in% c(75014, 75015, 75017) ~ "5.Family districts",
  TRUE ~ "6.Popular districts"
)

# d) Create a frequency table of the new variable
table(pizzerias$Arr_r)

table(pizzerias$Prices_r)

## e) Create a cross-tabulation table to test the relationship between the district and the price of pizza. Read the percentages from the cross-tabulation table.
pizzerias %>% select(Arr_r, Prices_r) %>% ### here we select our variables, the order: IV (independent variable), DV (dependent variable)
  table(exclude = NA) %>% ### we remove the NAs
  lprop(digits = 2, total = TRUE, percent = TRUE) ## we produce the table in %
## f) Create a bar chart for your cross-tabulation table.
## 

pizzerias$Arr <- as.factor(pizzerias$Arr)
pizzerias %>% ## we call the dataset
  drop_na(Prices_r) %>% ## we remove the NAs from the dependent variable 
  ggplot(mapping = aes(x = factor(Prices_r), group = Arr_r)) + ### we call the dependent variable based on the independent variable
  geom_bar(aes(y = ..prop.., fill = Arr_r), stat = "count", position = "dodge") + ## to calculate the graph in %
  #geom_text(aes(label = scales::percent(..prop.., accuracy = 1),
  #            y = ..prop..,), stat = "count", vjust = 0.09,
  #        position = position_dodge(.9)) + ##If you uncomment this, you will have the percentage on each bar
  #facet_grid(~Arr) +  ## if you uncomment this, you will have two graphs, one for females and one for males  
  scale_y_continuous(labels = scales::percent) + ## to set the y-axis in percentages 
  labs(x = "Pizza Price",
       y = "Percentage", fill = "District",
       title = "Pizza Price by District",
       #subtitle = "",
       caption = "Data source: la fourchette") + ## labels for axes, title, source 
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.caption = element_text(face = "italic"))### for formatting the title and source

## g) Perform a chi-square test for your variables and interpret the results. Can we retain our hypothesis/table?

chisq.test(pizzerias$Prices_r, pizzerias$Arr_r)

#The Chi-square test is a test of independence, meaning we want to determine if the two variables are independent within the population. Thus, the null hypothesis (H0) of the test is that the two variables are independent, while the alternative hypothesis (H1) suggests that the independent variable has an impact on the dependent variable. Interpretation is generally done using the p-value. With a confidence level of 95%, we reject H0 when the p-value is less than 0.05. This means that the probability of observing the occurrence of H0 is quite low. Thus, we can retain H1 and state that in our case, the price of pizza depends on the neighborhood. Therefore, we can reject H0 and maintain our hypothesis that the price of pizza is explained by the neighborhood where the pizzeria is located
