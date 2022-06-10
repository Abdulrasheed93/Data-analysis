# -*- coding: utf-8 -*-
"""
Created on Thu Jun  9 14:21:19 2022

@author: AbduulrasheedAdeleye
"""

import json
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt


#importing the json file
json_file = open(r"C:\Users\AbduulrasheedAdeleye\Documents\Python Scripts\loan_data_json.json")
Data = json.load(json_file)


#Transaforming the json file to Dataframe
BlueBank = pd.DataFrame(Data)


#Summary of the Dataframe
BlueBank.info()



#Formatting
BlueBank['purpose'] = BlueBank['purpose'].str.replace('_', ' ')



#Analysis on the Dataframe

#Using Exponent to get the annual income
BlueBank['annual.income'] = np.exp(BlueBank['log.annual.inc'])


#'for loop' condition for the FICO score
ficocat = []
for x in range(0, len(BlueBank)):
    category = BlueBank['fico'][x]
    if category >= 300 and category < 400:
        cat = 'Very Poor'
    elif category >= 400 and category < 600:
        cat = 'Poor'
    elif category >= 600 and category < 660:
        cat = 'Fair'
    elif category >= 660 and category < 700:
        cat = 'Good'
    elif category >= 700:
        cat = 'Excellent'
    else:
        cat = 'Unknown'
    ficocat.append(cat)
    
    
#converting ficocat list to series    
ficocat = pd.Series(ficocat)  


#adding a the ficocat loop to the dataframe
BlueBank['fico.category'] = ficocat
        


#Creating a new column for the Dataframe
BlueBank.loc[BlueBank['int.rate'] > 0.12, 'int.rate.type' ] = 'High' 
BlueBank.loc[BlueBank['int.rate'] <= 0.12, 'int.rate.type' ] = 'low' 



#Plotting graphs
CategoryPlot = BlueBank.groupby(['fico.category']).size()
CategoryPlot.plot.bar()
plt.show()

PurposePlot = BlueBank.groupby(['purpose']).size()
PurposePlot.plot.bar()
plt.show()


ypoint = BlueBank['annual.income']
xpoint = BlueBank['dti']
plt.scatter(xpoint, ypoint)
plt.show()

    
#exporting to csv for visualization on Tableau
BlueBank.to_csv('BlueBank_Cleaned.csv', index = True)







