import pandas as pd
import numpy as np


class Cleaner:
    def Null_Info(df : pd.DataFrame):
        print("Number of nulls in columns:")
        cols = df.columns
        result_ds = pd.DataFrame(index=(cols),columns=(["Nulls Count"]))
        for col in cols:
            result_ds.loc[col,"Nulls Count"] = int(df[col].isna().sum())          
        print(result_ds)
        
    def Category_Helper(df : pd.DataFrame):
        cols = df.columns
        result_df = pd.DataFrame(columns=("Column","Type","Unique Count", "Total Count","Is Category Good"))
        
        for col in cols:
            col_type = df[col].dtype
            count_unique = df[col].nunique()
            count_total = len(df[col])
            if col_type == object and count_unique < count_total*0.7: 
                cat_good = True
            else:
                cat_good = False            
            
            
            result_df.loc[len(result_df.index)]=[col,col_type,count_unique,count_total,cat_good]
        return result_df
     
    def Check_Category_Type(df : pd.DataFrame):
        print("If category type is good for columns:")
        result_df = Cleaner.Category_Helper(df)             
        print(result_df)
     
    def ChangeTypesToCategory(df : pd.DataFrame):
         helper_df = Cleaner.Category_Helper(df)
         for col in df.columns:
             if helper_df[helper_df["Column"] == col]["Is Category Good"].iloc[0]:           
                 df[col] = df[col].astype("category");        
        
    def Outliers_Info(df : pd.DataFrame, std_threshold = 1.5):
        print("Info about outliers:")
        result_df = pd.DataFrame(columns=("Column","Type","Mean", "Std","Outliers upper","Outliers lower"))
        for col in df.columns:
             if not df[col].dtype.name in ["object","category"]:
                 col_type = df[col].dtype
                 col_mean = df[col].mean()
                 col_std = df[col].std()
                 count_upper = len(df[(df[col] - col_mean)/col_std > std_threshold])
                 count_lower = len(df[(df[col] - col_mean)/col_std < -std_threshold])
                 result_df.loc[len(result_df.index)] =[col,col_type,round(col_mean,2),round(col_std,2),count_upper,count_lower]
                 
        print(result_df)
          
    def Print_Outliers(df : pd.DataFrame, col_name, std_threshold = 1.5):
        if not df[col_name].dtype.name in ["object","category"]:
            col_mean = round(df[col_name].mean(),2)
            col_std = round(df[col_name].std(),2)
            upper = df[(df[col_name] - col_mean)/col_std > std_threshold][col_name]
            lower = df[(df[col_name] - col_mean)/col_std < -std_threshold][col_name]
            if len(upper) > 0:
                print("Upper outliers:")
                print(upper)
                
            if len(lower) > 0:
                print("Lower outliers:")
                print(lower)
                
            if len(upper) == 0 and len(lower) ==0:
                print("No outliers found")              
        else:
            raise TypeError("Chosen column is not numeric")
            
    def Remove_Outliers(df : pd.DataFrame, cols=[],std_threshold = 1.5):
       if len(cols) == 0 :
           cols = df.columns
       for col in cols:
            if col in df.columns and not df[col].dtype.name in ["object","category"]:
                col_mean = df[col].mean()
                col_std = df[col].std()
                print(df[np.abs(df[col] - col_mean)/col_std > std_threshold])
                df = df[np.abs(df[col] - col_mean)/col_std <= std_threshold] 
                
       return df
   
    def Numeric_Info(df : pd.DataFrame):
        print('Numeric columns informations:')
        result_df = pd.DataFrame(columns=("Column","mean","median", "std","max","min"))
        for col in df.columns:
            if not df[col].dtype.name in ["object","category"]:
                mean = round(df[col].mean(),2)
                median = round(df[col].median(),2)
                std = round(df[col].std(),2)
                max_val = round(df[col].max(),2)
                min_val = round(df[col].min(),2)
                result_df.loc[len(result_df.index)] =[col,mean,median,std,max_val,min_val]
                
        print(result_df)
                

                     

sleepers = pd.read_csv("sleep_time.csv",usecols=("name","genus","vore","sleep_total","awake","brainwt","bodywt"))
print(sleepers.head())
print()
sleepers.info()

print()
Cleaner.Null_Info(sleepers)

print()
sleepers = sleepers.dropna()
sleepers.info()

print()
Cleaner.Check_Category_Type(sleepers)

print()
Cleaner.ChangeTypesToCategory(sleepers)
sleepers.info()

print()
Cleaner.Outliers_Info(sleepers)

print()
Cleaner.Print_Outliers(sleepers,"bodywt")

print()
sleepers = Cleaner.Remove_Outliers(sleepers,["bodywt"])
sleepers.info()

print()
Cleaner.Numeric_Info(sleepers)



