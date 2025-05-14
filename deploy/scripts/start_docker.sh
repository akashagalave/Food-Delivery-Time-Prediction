#!/bin/bash
# Log everything to start_docker.log
exec > /home/ubuntu/start_docker.log 2>&1

echo "Logging in to ECR..."
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 868402157267.dkr.ecr.ap-south-1.amazonaws.com

echo "Pulling Docker image..."
docker pull 868402157267.dkr.ecr.ap-south-1.amazonaws.com/food-time-prediction:latest

echo "Checking for existing container..."
if [ "$(docker ps -q -f name=food-time-prediction)" ]; then
    echo "Stopping existing container..."
    docker stop food-time-prediction
fi

if [ "$(docker ps -aq -f name=food-time-prediction)" ]; then
    echo "Removing existing container..."
    docker rm food-time-prediction
fi

echo "Starting new container..."
docker run -d -p 80:8000 --name food-time-prediction -e DAGSHUB_USER_TOKEN=d5e96b8bd217dd881bdb17e4859486e8f93bbbe4 868402157267.dkr.ecr.ap-south-1.amazonaws.com/food-time-prediction:latest

echo "Container started successfully."