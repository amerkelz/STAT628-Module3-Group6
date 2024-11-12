# STAT628-Module3-Group6
This repository contains data, code, and documentation for recreating Group 6's models and analysis of flight delays and cancellations for Module 3 of STAT 628 Fall 2024 at UW-Madison.

## To use this repository:
1. Pull the repository
2. Retrieve the raw flight data from the zip files listed in data/raw_data.txt
3. Move the data directory contents into the same directory as the code.
4. To recreate the models and analyses, run the code in the following order:
    1. weather.ipynb
    2. flight data.Rmd
    3. connect_flight_weather.ipynb
    4. snow_correction.ipynb
    5. model.ipynb
    6. CODENAME for data viz - CHENYU
5. The app folder contains all code used by the Shiny app, including pickle files of the models and python scripts to execute the models in the Shiny app
    - The Shiny app is hosted at https://amerkelz.shinyapps.io/628_module3_group6/
    - NOTE: if you use this code to host your own Shiny app, please update the author content information to your own

## Code Directory contents:
- weather.ipynb to preprocess the weather data
- flight data.Rmd to preprocess the flight data and separate them into years
- connect_flight_weather.ipynb to process and merge the flight and weather data
- snow_correction.ipynb to add back snowfall data from original raw data
- model.ipynb to develop the cancellation and delay models. The final models are saved as pickle files to be used by the Shiny app
- CODENAME to create trend analysis visualizations, which can be found in the images directory - CHENYU
  
## Data Directory contents: 

   
