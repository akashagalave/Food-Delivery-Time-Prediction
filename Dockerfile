# set the base image
FROM python:3.12-slim

# install lightgbm dependency
RUN apt-get update && apt-get install -y libgomp1

# set up the working directory
WORKDIR /app

# copy the requirements file
COPY requirements-docker.txt ./

# install the packages
RUN pip install --no-cache-dir -r requirements-docker.txt

# create directories for templates and static files
RUN mkdir -p templates static

# copy the app contents
COPY app.py ./
COPY ./models/preprocessor.joblib ./models/preprocessor.joblib
COPY ./scripts/data_clean_utils.py ./scripts/data_clean_utils.py
COPY ./run_information.json ./
COPY ./templates ./templates
COPY ./static ./static

# expose the port
EXPOSE 8000

# run the app with uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
