#!/bin/bash 
# Log everything to start_docker.log
exec > /home/ubuntu/start_docker.log 2>&1

echo "Logging in to ECR..."
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 868402157267.dkr.ecr.ap-south-1.amazonaws.com

echo "Pulling Docker image..."
docker pull 868402157267.dkr.ecr.ap-south-1.amazonaws.com/food-time-prediction:latest

echo "Checking for existing container..."
if [ "$(docker ps -q -f name=food-time-container)" ]; then
    echo "Stopping existing container..."
    docker stop food-time-container
fi

if [ "$(docker ps -aq -f name=food-time-container)" ]; then
    echo "Removing existing container..."
    docker rm food-time-container
fi

echo "Starting new container..."
docker run --name food-time-container -d -p 80:8000 -e DAGSHUB_USER_TOKEN=c0b55ec2a7cd91557d2cbb386b73e314cad6dd16 868402157267.dkr.ecr.ap-south-1.amazonaws.com/food-time-prediction:latest 

echo "Container started successfully."
