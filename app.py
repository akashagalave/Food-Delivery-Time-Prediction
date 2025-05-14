from fastapi import FastAPI, Form, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
from sklearn.pipeline import Pipeline
import uvicorn
import pandas as pd
import mlflow
import json
import joblib
from mlflow import MlflowClient
from sklearn import set_config
from scripts.data_clean_utils import perform_data_cleaning

# set sklearn to return pandas DataFrames
set_config(transform_output='pandas')

# initialize dagshub
import dagshub
dagshub.init(repo_owner='akashagalaveaaa1', repo_name='Food-Delivery-Time-Prediction', mlflow=True)

# set mlflow tracking URI
mlflow.set_tracking_uri("https://dagshub.com/akashagalaveaaa1/Food-Delivery-Time-Prediction.mlflow")

# Load run information
def load_model_information(file_path):
    with open(file_path) as f:
        return json.load(f)

# Load preprocessor
def load_transformer(transformer_path):
    return joblib.load(transformer_path)

# Columns info
num_cols = ["age", "ratings", "pickup_time_minutes", "distance"]
nominal_cat_cols = ['weather', 'type_of_order', 'type_of_vehicle', "festival", "city_type", "is_weekend", "order_time_of_day"]
ordinal_cat_cols = ["traffic", "distance_type"]

# Load model
client = MlflowClient()
model_name = load_model_information("run_information.json")['model_name']
stage = "Production"
model_path = f"models:/{model_name}/{stage}"
model = mlflow.sklearn.load_model(model_path)

# Load preprocessor
preprocessor = load_transformer("models/preprocessor.joblib")

# Build pipeline
model_pipe = Pipeline(steps=[
    ('preprocess', preprocessor),
    ('regressor', model)
])

# FastAPI app
app = FastAPI()

# Mount static folder and templates
app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")

# Home page: GET
@app.get("/", response_class=HTMLResponse)
def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request, "result": None})

# Prediction endpoint: POST from HTML form
@app.post("/predict", response_class=HTMLResponse)
def predict(
    request: Request,
    ID: str = Form(...),
    Delivery_person_ID: str = Form(...),
    Delivery_person_Age: str = Form(...),
    Delivery_person_Ratings: str = Form(...),
    Restaurant_latitude: float = Form(...),
    Restaurant_longitude: float = Form(...),
    Delivery_location_latitude: float = Form(...),
    Delivery_location_longitude: float = Form(...),
    Order_Date: str = Form(...),
    Time_Orderd: str = Form(...),
    Time_Order_picked: str = Form(...),
    Weatherconditions: str = Form(...),
    Road_traffic_density: str = Form(...),
    Vehicle_condition: int = Form(...),
    Type_of_order: str = Form(...),
    Type_of_vehicle: str = Form(...),
    multiple_deliveries: str = Form(...),
    Festival: str = Form(...),
    City: str = Form(...)
):
    input_df = pd.DataFrame({
        'ID': [ID],
        'Delivery_person_ID': [Delivery_person_ID],
        'Delivery_person_Age': [Delivery_person_Age],
        'Delivery_person_Ratings': [Delivery_person_Ratings],
        'Restaurant_latitude': [Restaurant_latitude],
        'Restaurant_longitude': [Restaurant_longitude],
        'Delivery_location_latitude': [Delivery_location_latitude],
        'Delivery_location_longitude': [Delivery_location_longitude],
        'Order_Date': [Order_Date],
        'Time_Orderd': [Time_Orderd],
        'Time_Order_picked': [Time_Order_picked],
        'Weatherconditions': [Weatherconditions],
        'Road_traffic_density': [Road_traffic_density],
        'Vehicle_condition': [Vehicle_condition],
        'Type_of_order': [Type_of_order],
        'Type_of_vehicle': [Type_of_vehicle],
        'multiple_deliveries': [multiple_deliveries],
        'Festival': [Festival],
        'City': [City]
    })

    cleaned_data = perform_data_cleaning(input_df)
    prediction = model_pipe.predict(cleaned_data)[0]

    return templates.TemplateResponse("index.html", {
        "request": request,
        "result": f"{prediction:.2f} minutes"
    })

# Run app
if __name__ == "__main__":
    uvicorn.run("app:app", host="0.0.0.0", port=8000, reload=True)
