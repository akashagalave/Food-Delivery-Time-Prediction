
---

<h1 align="center">🚚 Food Delivery Time Predictor</h1>

<p align="center">
  <b>Predicting food delivery time accurately to improve customer experience and optimize operations.</b><br/>
  <i>From order details to precise delivery time forecasts — empowering restaurants, delivery partners, and customers.</i>
</p>

---

## 🔍 Overview

This is a machine learning-powered application that predicts **food delivery time** based on order parameters. Built using **Streamlit** for an interactive UI and served via a **Dockerized Flask API backend**, it is deployed on a **scalable AWS cloud infrastructure** with automated deployment and scaling.

---

## 💼 Problem Statement

Customers often experience long or unpredictable delivery times, which leads to dissatisfaction. Restaurants and delivery services face inefficiencies without accurate delivery time predictions.

---

## 🎯 Objective

* Predict **food delivery time** using order features such as order type, weather, traffic conditions, and distance.
* Develop a robust ML model trained on historical delivery data.
* Build a user-friendly **Streamlit UI** for real-time predictions.
* Deploy the solution using **Docker** containers.
* Implement a **scalable, auto-scaling AWS infrastructure** with CI/CD pipeline for smooth updates.

---

## 💡 Business Impact

| 🧑‍🤝‍🧑 Stakeholder       | 📈 Value Delivered                                       |
| -------------------------- | -------------------------------------------------------- |
| 🍽️ **Restaurants**        | Improve order scheduling and reduce late deliveries      |
| 🚚 **Delivery Partners**   | Better route planning and workload management            |
| 🧑‍💻 **Customers**        | Reliable estimated delivery times enhancing satisfaction |
| 📊 **Operations Managers** | Data-driven insights for optimizing delivery logistics   |
| 💼 **Business**            | Increased customer retention and operational efficiency  |

---

## 🧠 ML Intelligence

| Component     | Description                                                                 |
| ------------- | --------------------------------------------------------------------------- |
| Model         | `GradientBoostingRegressor`                                                 |
| Target        | Food delivery time in minutes                                               |
| Features      | Order type, distance, weather, traffic, etc.                                |
| Training Data | Historical delivery records                                                 |
| Versioning    | `DVC` for data & pipeline version control, `MLflow` for experiment tracking |
| Output        | Real-time delivery time prediction                                          |

---

## 🗺️ App Features

* 🖥️ **Interactive Streamlit Web App**
* ⏱️ Predicts delivery time based on user input
* 📊 Visualizes prediction and key influencing factors
* 📦 Fully **Dockerized backend and frontend**
* 🧪 End-to-end reproducible ML experiments with tracked metrics

---

## ☁️ Cloud Architecture (AWS)

| Component                 | Description                                      |
| ------------------------- | ------------------------------------------------ |
| 🐳 **Docker**             | Containerizes backend and frontend               |
| 🧠 **Flask API**          | Serves model inference to Streamlit UI           |
| ☁️ **AWS EC2**            | Hosts the application in scalable VM instances   |
| ⚖️ **Load Balancer**      | Distributes traffic for high availability        |
| 📈 **Auto Scaling Group** | Scales EC2 instances up/down based on usage      |
| 🧬 **Launch Template**    | Ensures consistent EC2 instance configuration    |
| 🚀 **AWS CodeDeploy**     | Enables continuous deployment via CI/CD pipeline |

---

## 🧰 Tech Stack

| Layer           | Tools & Frameworks                                                            |
| --------------- | ----------------------------------------------------------------------------- |
| **ML Modeling** | `GradientBoostingRegressor`, `scikit-learn`, `pandas`, `joblib`               |
| **MLOps**       | `DVC`, `MLflow`, `Git` version control, CI/CD with `AWS CodeDeploy`           |
| **Frontend**    | `Streamlit` for fast, clean, interactive UI                                   |
| **Backend**     | `Flask` API for model serving                                                 |
| **Deployment**  | `Docker`, `AWS EC2`, `Load Balancer`, `Auto Scaling Group`, `Launch Template` |


---

---

## 🎥 Live Demo – Screenshots 

▶️ **Watch the App Running on AWS**

![App Screenshot 1](path/to/screenshot1.png)  
![App Screenshot 2](path/to/screenshot2.png)  


---

## 🧪 Run Locally – Try It Yourself

### 1️⃣ Clone and Install

```bash
git clone https://github.com/akashagalave/food-delivery-time-predictor.git
cd food-delivery-time-predictor
pip install -r requirements.txt
```

### 2️⃣ Run the Streamlit App

```bash
streamlit run app.py
```

Open `http://localhost:8501` in your browser.

---

### 3️⃣ Use the Interface

* Enter order details (type, distance, weather, traffic, etc.)
* Get an estimated **delivery time prediction** instantly

---

## 📁 Data Overview

* 📍 **Source**: Historical food delivery records (location, time, weather, traffic, order type)
* 📊 **Features**: Distance, weather, order type, traffic conditions, delivery time
* 🧹 Data cleaned, feature-engineered, and split for model training

---

## 📌 Project Status

✅ Deployed with autoscaling and CI/CD
📹 Demo recorded on live AWS infrastructure
📦 Currently offline (infra shut down for cost control)
💻 Fully reproducible via local environment

---

## 🙌 Built With Grit By

👨‍💻 [Akash Agalave](https://github.com/akashagalave)

---


