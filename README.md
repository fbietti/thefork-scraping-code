# the fork scraping code

This project arose from the need to find new topics for my data analysis assignments at the university. The idea was to identify data online, structure it into a dataset, then conduct analyses and engage the students in practical exercises!

In this project, you will find a file for web scraping data from The Fork website. It is a Python code and is well-commented. It does not require prior knowledge of HTML or CSS. You just need to know how to identify the element you are interested in on the site and copy the corresponding code into the for loop.

## File: scraping_code

This file contains the code for performing web scraping. First, you need to go to The Fork website and initiate your search. In my case, I was interested in Parisian pizzerias, so I launched a search with the keyword 'pizzeria.' The site responded with 168 pages of results. Each page contains multiple results, and each result corresponds to a pizzeria. Each result includes various elements, such as the address, price, pizzeria name, etc.

You should inspect the element you are interested in. In my case, I focused on the pizzeria name, rating, price, review, and address. I initialized lists for each of these elements and also set up page numbers so that the code could navigate from one page to another.

Next, using the lists, I created a dictionary, and I transformed the dictionary into a data frame. Finally, with the data frame, I exported a CSV file.

## File: celaningdataset

This file contains R commands to effectively structure our database. The manipulations involve extracting the district number from the address, enabling the comparison of average prices for pizzerias in different neighborhoods of Paris.

## File: assignmet_pizza_price_paris

This file contains an exercise that, if you are a teacher, you can give to your data analysis students. I wrote it in R, but it can be easily translated into Python if you prefer. It starts with some commands to change variable types or find individuals, etc., and continues with recoding and bivariate analyses. I ask students to create tables, formulate hypotheses, test them, and create a graph. The file contains the answers to each question

![Alt text]('https://github.com/fbietti/thefork-scraping-code/blob/main/plots/pizza.png')