import pandas as pd
import numpy as np


class Cleaner:
    def null_info(df : pd.DataFrame):
        print("Number of nulls in columns:")
        cols = df.columns
        result_ds = pd.DataFrame(index=(cols),columns=(["Nulls_Count","Nulls_percent"]))
        for col in cols:
            result_ds.loc[col,"Nulls_Count"] = int(df[col].isna().sum())        
            result_ds.loc[col,"Nulls_percent"] = round(result_ds.loc[col,"Nulls_Count"]/df[col].count(),2) 
        print(result_ds)
        
    def __category_helper(df : pd.DataFrame):
        cols = df.columns
        result_df = pd.DataFrame(columns=("Column","Type","Unique_Count", "Total_Count","Is_Category_Good"))
        
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
     
    def check_category_type(df : pd.DataFrame):
        print("If category type is good for columns:")
        result_df = Cleaner.__category_helper(df)             
        print(result_df)
     
    def change_types_to_category(df : pd.DataFrame):
         helper_df = Cleaner.__category_helper(df)
         for col in df.columns:
             if helper_df[helper_df["Column"] == col]["Is_Category_Good"].iloc[0]:           
                 df[col] = df[col].astype("category");        
        
    def outliers_info(df : pd.DataFrame, std_threshold = 1.5):
        print("Info about outliers:")
        result_df = pd.DataFrame(columns=("Column","Type","Mean", "Std","Outliers_upper","Outliers_lower"))
        for col in df.columns:
             if not df[col].dtype.name in ["object","category","bool","datetime64[ns]"]:
                 col_type = df[col].dtype
                 col_mean = df[col].mean()
                 col_std = df[col].std()
                 count_upper = len(df[(df[col] - col_mean)/col_std > std_threshold])
                 count_lower = len(df[(df[col] - col_mean)/col_std < -std_threshold])
                 result_df.loc[len(result_df.index)] =[col,col_type,round(col_mean,2),round(col_std,2),count_upper,count_lower]
                 
        print(result_df)
          
    def print_outliers(df : pd.DataFrame, col_name, std_threshold = 1.5):
        if not df[col_name].dtype.name in ["object","category","bool","datetime64[ns]"]:
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
            
    def remove_outliers(df : pd.DataFrame, cols=[],std_threshold = 1.5):
       if len(cols) == 0 :
           cols = df.columns
       for col in cols:
            if col in df.columns and not df[col].dtype.name in ["object","category","bool","datetime64[ns]"]:
                col_mean = df[col].mean()
                col_std = df[col].std()
                print(df[np.abs(df[col] - col_mean)/col_std > std_threshold])
                df = df[np.abs(df[col] - col_mean)/col_std <= std_threshold] 
                
       return df
   
    def numeric_info(df : pd.DataFrame):
        print('Numeric columns informations:')
        result_df = pd.DataFrame(columns=("Column","mean","median", "std","max","min"))
        for col in df.columns:
            if not df[col].dtype.name in ["object","category","bool","datetime64[ns]"]:
                mean = round(df[col].mean(),2)
                median = round(df[col].median(),2)
                std = round(df[col].std(),2)
                max_val = round(df[col].max(),2)
                min_val = round(df[col].min(),2)
                result_df.loc[len(result_df.index)] =[col,mean,median,std,max_val,min_val]
                
        print(result_df)

    def int_sizes_info(df : pd.DataFrame):
        print('Int columns informations:')
        result_df = pd.DataFrame(columns=("Column","current_dtype","optimal_dtype","max","min" ))
        MAX_INT32 = 2**31 - 1
        MAX_INT16 = 2**15 - 1
        MAX_INT8 = 2**7 - 1
        MAX_UINT32 = 2**32 - 1
        MAX_UINT16 = 2**16 - 1
        MAX_UINT8 = 2**8 - 1

        for col in df.columns:
            if df[col].dtype.name in ["int64","int32"]:
                max_val = df[col].max()
                min_val = df[col].min()
                optimal_type = df[col].dtype.name
                if min_val >= 0:
                    if max_val <= MAX_UINT8:
                        optimal_type = "uint8"
                    elif max_val <= MAX_UINT16:
                        optimal_type = "uint16"
                    elif max_val <= MAX_UINT32:
                        optimal_type = "uint32"
                    else:
                        optimal_type = "uint64"
                else:
                    if max(max_val,abs(min_val)) <= MAX_INT8:
                        optimal_type = "int8"
                    elif max(max_val,abs(min_val)) <= MAX_INT16:
                        optimal_type = "int16"
                    elif max(max_val,abs(min_val)) <= MAX_INT32:
                        optimal_type = "int32"
                    else:
                        optimal_type = "int64"

                result_df.loc[len(result_df.index)] = [col,df[col].dtype.name,optimal_type,max_val,min_val]
                
        print(result_df)
                

if __name__ == "__main__":                    

    sleepers = pd.read_csv("sleep_time.csv",usecols=("name","genus","vore","sleep_total","awake","brainwt","bodywt"))
    print(sleepers.head())
    print()
    sleepers.info()

    print()
    Cleaner.null_info(sleepers)

    print()
    sleepers = sleepers.dropna()
    sleepers.info()

    print()
    Cleaner.check_category_type(sleepers)

    print()
    Cleaner.check_category_type(sleepers)
    sleepers.info()

    print()
    Cleaner.outliers_info(sleepers)

    print()
    Cleaner.print_outliers(sleepers,"bodywt")

    print()
    sleepers = Cleaner.remove_outliers(sleepers,["bodywt"])
    sleepers.info()

    print()
    Cleaner.numeric_info(sleepers)

    print()
    Cleaner.int_sizes_info(sleepers)
