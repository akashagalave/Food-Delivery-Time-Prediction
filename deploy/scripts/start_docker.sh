#!/bin/bash

exec > /home/ubuntu/start_docker.log 2>&1
set -e
set -x

echo "Cleaning up old Docker containers and images..."
docker stop food-time-container || true
docker rm food-time-container || true
docker system prune -af

echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 868402157267.dkr.ecr.ap-south-1.amazonaws.com

echo "Pulling latest Docker image..."
docker pull 868402157267.dkr.ecr.ap-south-1.amazonaws.com/food-time-prediction:latest

echo "Running new container..."
docker run -d \
  --name food-time-container \
  -p 80:8000 \
  -w /app \
  --env DAGSHUB_USER_TOKEN="${DAGSHUB_TOKEN}" \
  868402157267.dkr.ecr.ap-south-1.amazonaws.com/food-time-prediction:latest

echo "Deployment completed successfully."
