# set the base image
FROM python:3.12-slim

# install lightgbm dependency (needed for sklearn if lightgbm is used)
RUN apt-get update && apt-get install -y libgomp1 && apt-get clean

# set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# set the working directory
WORKDIR /app

# copy requirements file and install dependencies
COPY requirements-docker.txt ./
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements-docker.txt

# copy application code
COPY app.py ./
COPY ./models/preprocessor.joblib ./models/preprocessor.joblib
COPY ./scripts/data_clean_utils.py ./scripts/data_clean_utils.py
COPY ./run_information.json ./
COPY ./templates ./templates
COPY ./static ./static

# expose port
EXPOSE 8000

# run the FastAPI app using uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
