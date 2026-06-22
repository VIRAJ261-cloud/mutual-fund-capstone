import os
import pandas as pd
import numpy as np

folder = os.path.join(os.getcwd(),"data","raw")
files = [f for f in os.listdir(folder) if f.endswith('.csv')]
df_list = {}
for file in files:
    file_path = os.path.join(folder, file)
    df = pd.read_csv(file_path)
    df_list[file.split('.')[0]] = df
    print(f"\nDataset {file}\n")
    print("First 5 rows:")
    print(df.head())
    print("\nData types:")
    print(df.dtypes)
    print("Shape of the dataset:", df.shape)

