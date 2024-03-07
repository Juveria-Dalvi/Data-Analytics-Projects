# pip install pandas
# pip install -U ydata_profiling

import pandas as pd
from ydata_profiling import ProfileReport


df = pd.read_csv('DatasetsFiles/Weather_Dataset_for_Forecasting.csv')
print(df)

#Generate a report
profile = ProfileReport(df)
profile.to_file(output_file="Weather_Forecast_Report.html")