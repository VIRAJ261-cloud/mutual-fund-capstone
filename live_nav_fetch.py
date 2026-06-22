import requests
import pandas as pd
import os

folder = os.path.join(os.getcwd(), "data", "raw")
url = "https://api.mfapi.in/mf/125497"

response = requests.get(url)
try:
    if response.status_code == 200:
        data = response.json()
        nav_data = data["data"]
        df = pd.DataFrame(nav_data)
        df.columns = ["date", "nav"]
        df["date"] = pd.to_datetime(df["date"], format="%d-%m-%Y")
        df["nav"] = pd.to_numeric(df["nav"], errors="coerce")
        df = df.sort_values(by="nav", ascending=False)
        df.to_csv(os.path.join(folder, "hdfc_100.csv"), index=False)
        print("Data fetched and saved successfully.")
except Exception as e:
    print(f"Error occurred while fetching data: {e}")
    