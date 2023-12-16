from bs4 import BeautifulSoup
import requests
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
%matplotlib inline


page = 1
pizzeria = []
ratings = []
reviews = []
prices = []
adresse = []

# token 
user_agent = ({'User-Agent':
'Mozilla/5.0 (Windows NT 10.0; Win64; x64) \
AppleWebKit/537.36 (KHTML, like Gecko) \
Chrome/90.0.4430.212 Safari/537.36',
'Accept-Language': 'en-US, en;q=0.5'})


# for ex page number should be <= 14 as website contains only 14 pages

while page != 168:
    url = f"https://www.thefork.fr/search?cityId=415144&p={page}"
    response = requests.get(url,headers = user_agent)
    soup = BeautifulSoup(response.text, "html.parser")
    page = page + 1

    for name in soup.findAll('div',{'class':'css-fqnmwb elkhwc30'}):        
        pizzeria.append(name.text.strip())
       
    for rating in soup.find_all('span',{'class':'css-13xokbo e7dhrrp0'}):
        ratings.append(rating.text.replace(' / 10','').strip())
   
    for review in soup.findAll('span',{'class':'css-zyn6ii eulusyj0'}):
        reviews.append(review.text.replace('\u202f','').replace(' avis','').strip())
   
    for p in soup.findAll('p',{'class':'css-6pr0fg eulusyj0'}):
        prices.append(p.text.replace('\xa0€','').replace('Prix moyen ','').replace(' Accepte les Yums','').strip())
   
    for a in soup.findAll('p',{'class':'css-ibqusf eulusyj0'}):
        adresse.append(a.text.replace('\n','').strip())


# Create a dictionary.
dict = {'Pizzeria':pizzeria,'Ratings':ratings,'Number of Reviews':reviews,'Prices':prices, 'Adresse':adresse}


# Create a dataframe.
pizzerias = pd.DataFrame.from_dict(dict)
pizzerias.head(10)


# Convert your dataframe to CSV file.
pizzerias.to_csv('pizzerias.csv', index=False, header=True)


