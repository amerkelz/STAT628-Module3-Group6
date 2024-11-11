# STAT628-Module3-Group6
This repository contains data, code, and documentation for recreating Group 6's models and analysis of flight delays and cancellations for Module 3 of STAT 628 Fall 2024 at UW-Madison.

To use this repository:
1. Pull the repository
2. Retrieve the raw data from the zip files listed in raw_data.txt
3. Move the raw data into the same directory as the code.
4. To recreate the models and analyses, run the code in the following order:
    - Run <CODENAME to preprocess the weather data
    - Run <CODENAME to preprocess the flight data
    - Run connect_flight_weather.ipynb to process and merge the flight and weather data
    - Run <CODENAME to develop the cancellation and delay models. Models are saved as pickle files to be used by the Shiny app
    - Run <CODENAME to create trend analysis visualizations, which can be found in the images directory
5. The app folder contains all code used by the Shiny app, including pickle files of the models
    - The Shiny app is hosted at <URL>
    - NOTE: if you use this code to host your own Shiny app, please update the author content information to your own
    
   
