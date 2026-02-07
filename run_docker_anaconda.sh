#!/bin/bash

# Variables
CONTAINER_NAME="anaconda_data_engineering"
IMAGE_NAME="continuumio/anaconda3:latest"
MOUNT_PATH_ON_HOST="/Users/jsperson"
MOUNT_PATH_IN_CONTAINER="/home/jsperson/host"

# Check if the container exists
CONTAINER_ID=$(docker ps -a -q -f name=$CONTAINER_NAME)

# If the container does not exist, create and run it
if [ -z "$CONTAINER_ID" ]; then
    echo "Container does not exist. Creating and starting..."
    docker run -d \
      --name $CONTAINER_NAME \
      -v $MOUNT_PATH_ON_HOST:$MOUNT_PATH_IN_CONTAINER \
      $IMAGE_NAME \
      tail -f /dev/null
else
    # Check if the container is running
    RUNNING_CONTAINER_ID=$(docker ps -q -f name=$CONTAINER_NAME)
    if [ -z "$RUNNING_CONTAINER_ID" ]; then
        echo "Container exists but is stopped. Starting..."
        docker start $CONTAINER_NAME
    else
        echo "Container is already running."
    fi
fi

# Connect to the container
echo "Connecting to container..."
docker exec -it $CONTAINER_NAME bash
