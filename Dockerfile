FROM python:3.12-slim

RUN apt-get update && apt-get install -y libgomp1

WORKDIR /app

COPY requirements-docker.txt ./
RUN pip install --no-cache-dir -r requirements-docker.txt

COPY app.py .
COPY run_information.json .
COPY models/preprocessor.joblib models/
COPY scripts/data_clean_utils.py scripts/

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]