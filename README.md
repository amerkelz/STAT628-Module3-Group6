# STAT628-Module3-Group6
This repository contains data, code, and documentation for recreating Group 6's models and analysis of flight delays and cancellations for Module 3 of STAT 628 Fall 2024 at UW-Madison.

To use this repository:
1. Pull the repository
2. Retrieve the raw data from the zip files listed in data/raw_data.txt
3. Move the raw data into the same directory as the code.
4. To recreate the models and analyses, run the code in the following order:
    - Run weather.ipynb to preprocess the weather data
    - Run flight data.Rmd to preprocess the flight data and seperate them into years.
    - Run connect_flight_weather.ipynb to process and merge the flight and weather data
    - Run snow_correction.ipynb to add back snowfall data from original raw data
    - Run model.ipynb to develop the cancellation and delay models. Models are saved as pickle files to be used by the Shiny app
    - Run <CODENAME to create trend analysis visualizations, which can be found in the images directory - CHENYU
5. The app folder contains all code used by the Shiny app, including pickle files of the models and python scripts to execute the models in the Shiny app - AMY
    - The Shiny app is hosted at <URL>
    - NOTE: if you use this code to host your own Shiny app, please update the author content information to your own


    
   
