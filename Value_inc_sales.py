import pandas as pd

#importing the csv file
transaction = pd.read_csv(r"C:\Users\AbduulrasheedAdeleye\Downloads\Materials\Python files\transaction.csv", sep=";")


#Summary of the dataframe
transaction.info()


#Data Transformation and Cleaning
transaction["Date"] = transaction['Day'].astype(str) + '-' + transaction['Month'] + '-' + transaction['Year'].astype(str)


#Splitting columns
split_col = transaction['ClientKeywords'].str.split(',' , expand=True)


#appending the splitted columns
transaction['ClientAge'] = split_col[0]
transaction['ClientType'] = split_col[1]
transaction['LengthOfContract'] = split_col[2]


#Formatting the ClientAge column
transaction['ClientAge'] = transaction['ClientAge'].str.replace('[', '')


#Formatting the LengthOfContract column
transaction['LengthOfContract'] = transaction['LengthOfContract'].str.replace(']', '')


#Coverting to lowercase
transaction['ItemDescription'] = transaction['ItemDescription'].str.lower()


#Removing columns
transaction = transaction.drop(['Year', 'Month', 'Day', 'ClientKeywords'], axis =1)


#Performing calcuation on the dataframe

#calculating the CostPerTransaction
transaction['CostPerTransaction'] = transaction['CostPerItem'] * transaction['NumberOfItemsPurchased']


#calculating the SalesPerTransaction
transaction['SalesPerTransaction'] = transaction['SellingPricePerItem'] * transaction['NumberOfItemsPurchased']


#calculating the ProfitPerTransaction
transaction['ProfitPerTransaction'] = transaction['SalesPerTransaction'] - transaction['CostPerTransaction']


#calculating the Markup
transaction['Markup'] = transaction['ProfitPerTransaction'] / transaction['CostPerTransaction']


#rouding up the Markup
transaction['Markup'] = round(transaction['Markup'], 2)




#exporting to a csv
transaction.to_csv('Transaction_Cleaned.csv', index = False)
