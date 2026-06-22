import requests
import pandas as pd
import os

schemes = {
    "sbi_bluechip": 119551,
    "icici_bluechip": 120503,
    "nippon_large_cap": 118632,
    "axis_bluechip": 119092,
    "kotak_bluechip": 120841
}

for key,value in schemes.items():
    folder = os.path.join(os.getcwd(), "data", "raw")
    url = f"https://api.mfapi.in/mf/{value}"

    response = requests.get(url)
    try:
        if response.status_code == 200:
            data = response.json()
            nav_data = data["data"]
            df = pd.DataFrame(nav_data)
            df.columns = ["date", "nav"]
            df["date"] = pd.to_datetime(df["date"], format="%d-%m-%Y")
        df["nav"] = pd.to_numeric(df["nav"], errors="coerce")
        df.to_csv(os.path.join(folder, f"{key}.csv"), index=False)
        print(f"Data for {key} fetched and saved successfully.")
    except Exception as e:
        print(f"Error occurred while fetching data for {key}: {e}")