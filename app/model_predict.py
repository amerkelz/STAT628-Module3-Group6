#load in model
 
import pickle
import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
import sklearn

def predict_cancel(month, vis, wind, snow_origin, snow_dest):
    with open('cancel_model.pkl', 'rb') as f:
        cancel_model = pickle.load(f)
    
    data = {'Month': [month], 'Vis_ORIGIN_category': [vis], 'Wind_DEST_category': [wind], 'Snow_ORIGIN_category':[snow_origin], 'Snow_DEST_category':[snow_dest]}
    X = pd.DataFrame(data)
    
    return cancel_model.predict_proba(X)

def predict_delay(month, hour, vis, wind, snow_origin, snow_dest):
    with open('delay_model.pkl','rb') as f:
        delay_model = pickle.load(f)
    
    data = {'Month': [month], 'Hour':[hour], 'Vis_ORIGIN_category': [vis], 'Wind_DEST_category': [wind], 'Snow_ORIGIN_category':[snow_origin], 'Snow_DEST_category':[snow_dest]}
    X = pd.DataFrame(data)
    
    return delay_model.predict(X)