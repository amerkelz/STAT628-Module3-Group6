# STAT628-Module3-Group6
This repository contains data, code, and documentation for recreating Group 6's models and analysis of flight delays and cancellations for Module 3 of STAT 628 Fall 2024 at UW-Madison.

## To use this repository:
1. Pull the repository
2. Retrieve the raw flight data from the zip files listed in data/raw_data.txt
3. Move the csv files in the data directory into the same directory as the code.
4. To recreate the models and analyses, run the code in the following order:
    1. weather.ipynb
    2. flight data.Rmd
    3. connect_flight_weather.ipynb
    4. snow_correction.ipynb
    5. model.ipynb
    6. final_visualization.Rmd
5. The app folder contains all code used by the Shiny app, including pickle files of the models and python scripts to execute the models in the Shiny app
    - The Shiny app is hosted at https://amerkelz.shinyapps.io/628_module3_group6/
    - NOTE: if you use this code to host your own Shiny app, please update the author content information to your own

### Code Directory Contents:
- weather.ipynb: preprocess the weather data
- flight data.Rmd: preprocess the flight data and separate them into years
- connect_flight_weather.ipynb: process and merge the flight and weather data
- snow_correction.ipynb: add back snowfall data from original raw data
- model.ipynb: develop the cancellation and delay models. The final models are saved as pickle files to be used by the Shiny app
- final_visualization.Rmd: create trend analysis visualizations, which can be found in the images directory
  
### Data Directory Contents: 
- raw flight data.rtf: contains URL to access the raw flight data used by flight data.Rmd. URL can only be accessed by UW-Madison students, faculty, and staff.
- airport_codes_lat_long.csv: used by flight data.Rmd. Created manually.
- airport_timezone.csv: used by connect_flight_weather.ipynb. Created manually.
- final_data.txt: contains URL to access final cleaned data created during Step 4 of using this repository (above). URL can only be accessed by UW-Madison students, faculty, and staff.

### App Directory Contents:
- app.R: runs the Shiny app UI and server
- cancel_model.pkl: cancellation model developed in model.ipynb
- delay_model.pkl: delay model developed in model.ipynb
- model_predict.py: script containing functions to make cancellation and delay predictions from the models using Shiny app inputs
- deploy.R: uses rsconnect to upload app to shinyapps.io

### Images Directory Contents:
- Cancellation_rate_Distribution.png: shows the distribution of cancellation rates for different airports
- delay_by_day.png: shows the delay types for different days of week
- delay_by_hour.png: shows the percentage of delay types for different hours
- Delay_Distribution.png: shows the percentage of different delay types
- monthly_data_plot.png: shows the cancellation rates in different months in different years

   
