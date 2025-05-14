#!/bin/bash
exec > /home/ubuntu/start_docker.log 2>&1

echo "Cleaning up old Docker containers and images..."
docker system prune -af

echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 868402157267.dkr.ecr.ap-south-1.amazonaws.com

echo "Pulling latest Docker image..."
docker pull 868402157267.dkr.ecr.ap-south-1.amazonaws.com/food-time-prediction:latest

echo "Stopping existing container..."
docker stop food-time-container || true
docker rm food-time-container || true

echo "Running new container with mounted /app..."
docker run -d \
  --name food-time-container \
  -p 80:80 \
  -v /home/ubuntu/app:/app \
  -w /app \
  -e DAGSHUB_USER_TOKEN=d5e96b8bd217dd881bdb17e4859486e8f93bbbe4 \
  868402157267.dkr.ecr.ap-south-1.amazonaws.com/food-time-prediction:latest \
  uvicorn app:app --host 0.0.0.0 --port 80

echo "Deployment completed successfully."
