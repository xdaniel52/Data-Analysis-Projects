import pyodbc
import pandas as pd
from datetime import date, timedelta
from random import random, randint


connection = pyodbc.connect('DRIVER={SQL Server Native Client 11.0};SERVER=DANIEL-WIN;DATABASE=Gym;Trusted_Connection=yes;')

sqlDiscountsQuery = """SELECT  [ServiceID],
                        [Discounts].CardTypeID,
                        [Discounts].Fraction,
                        [Price],
                        [ServiceTypes].[DurationInHours],
                        [Duration]
                    FROM [Gym].[dbo].[Services] 
                    JOIN [Gym].[dbo].[Discounts] 
                        ON([Gym].[dbo].[Services].[ServiceTypeID] = [Gym].[dbo].[Discounts].[ServiceTypeID])
                    JOIN [Gym].[dbo].[ServiceTypes]
                        ON([Gym].[dbo].[Services].[ServiceTypeID] = [Gym].[dbo].[ServiceTypes].[ServiceTypeID]);"""

# collecting and declaring data
Discounts = pd.read_sql(sqlDiscountsQuery,connection)
Customers = pd.DataFrame(columns=['Index','CardTypeID','PurchaseDate'])
Purchases = pd.DataFrame(columns=['ServiceID','CardID','CustomerID','EmployeeID','PurchaseDate','Price','To'])
n_customers = 70
n_services = Discounts['ServiceID'].nunique()
print(f'n_services: {n_services}')


current_date = date(2020,1,2) #declare start date
current_CardTypeID = 3

# generate purchases for membership cards
for customer_idx in range(1,n_customers+1):
    if customer_idx < 5:
        # generete cards for employees
        Customers.loc[customer_idx] = [customer_idx,3,current_date]
    else:

        # generete date of purchase
        if customer_idx <= 40:
            current_date+= timedelta(days=randint(0,10))

            if customer_idx == 40:
                current_date = date(2021,1,2) 

        elif customer_idx <= 60:
            current_date+=timedelta(days=randint(0,15))

            if customer_idx == 60:
                current_date = date(2022,1,2)

        else:
            current_date+=timedelta(days=randint(0,20))

        # generete card type
        random_num = random()
        if random_num < 0.6:
            current_CardTypeID = 1
        elif random_num < 0.8:
            current_CardTypeID = 2
        else:
            current_CardTypeID = 4

        Customers.loc[customer_idx] = [customer_idx,current_CardTypeID,current_date]

    employee_id = randint(7,9)# randomly select an receptionist
    price = 15.00 if current_CardTypeID==1 or current_CardTypeID==4 else 100 if current_CardTypeID==2 else 5.00 #select a price for card
    Purchases.loc[len(Purchases)] = [current_CardTypeID+15,'null',customer_idx,employee_id,current_date,price,current_date]

services_groups = [[1,2,3,4,5,6],[9,10,11,12],[1,2,7,13],[13,14,15,7],[1,2,3,4,9,10,11,12]] # define 5 type of customers and their most liked services

# generate purchases every customer with ID = 1..70
for customer_idx in range(1,n_customers+1):
    customer_date = Customers.loc[customer_idx,'PurchaseDate']+timedelta(days=randint(1,3))
    service_idx = 0 
    customer_cardtype = Customers.loc[customer_idx,'CardTypeID']
    customer_type = randint(0,4)
    while customer_date < date(2023,1,1):
        if random() < 0.95: # check if customer will automatically buy new service or take a break
            
            if random()<0.1: # check if customer will buy random service or one of the most liked services
                service_idx = randint(1,15)
            else:
                service_idx = services_groups[customer_type][randint(0,len(services_groups[customer_type])-1)]

            employee_id = randint(7,9) # randomly select an receptionist
            row = Discounts.where((Discounts['ServiceID']==service_idx) & (Discounts['CardTypeID']==customer_cardtype)).dropna()
            if len(row) == 0:
                row = Discounts.where((Discounts['ServiceID']==service_idx)).dropna().iloc[0]
                price = row['Price']
            else:
                row = row.iloc[0]
                price = round(row['Price'] * (1 - row['Fraction']),2)
                
            if row['DurationInHours']:
                additional_time = timedelta(days=0)
            else:
                additional_time = timedelta(days=row['Duration'])

            #add service to DataFrame
            Purchases.loc[len(Purchases)] = [service_idx,customer_idx,customer_idx,employee_id,customer_date,price,customer_date+additional_time]

            # add time to current_date to determine next date of customer purchase
            if row['DurationInHours']:
                additional_time += timedelta(days=randint(2,10))
            else:
                additional_time += timedelta(days=randint(0,5))
            customer_date+=additional_time 

        else:
            customer_date+=timedelta(days=randint(20,30))

# sort all purchases by date and write them to file
Purchases = Purchases.sort_values(by='PurchaseDate',ascending=True)
file = open("result.txt", "w")
for row in Purchases.iterrows():
    row = row[1]
    file.write(f"EXEC addPurchase @ServiceID={row['ServiceID']},@EmployeeID={row['EmployeeID']},@Date='{row['PurchaseDate']}',@Price={row['Price']},@CardID={row['CardID']},@CustomerID={row['CustomerID']},@From='{row['PurchaseDate']}',@To='{row['To']}';\n")

file.close()

# print number of purchases generated
print(f"generated purchases: len(Purchases)")
