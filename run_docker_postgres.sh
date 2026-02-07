#!/bin/bash

# Variables
CONTAINER_NAME="postgres_data_engineering"
IMAGE_NAME="postgres:latest"
POSTGRES_USER="admin"
POSTGRES_PW="admin"
POSTGRES_DB="salestracker"
POSTGRES_PORT="5432"
#MOUNT_PATH_ON_HOST="/Users/jsperson"
#MOUNT_PATH_IN_CONTAINER="/home/jsperson/host"

# Check if the container exists
CONTAINER_ID=$(docker ps -a -q -f name=$CONTAINER_NAME)

# If the container does not exist, create and run it
if [ -z "$CONTAINER_ID" ]; then
    echo "Container does not exist. Creating and starting..."
    docker run -d \
      --name $CONTAINER_NAME \
      -e POSTGRES_USER=$POSTGRES_USER \
      -e POSTGRES_PASSWORD=$POSTGRES_PW \
      -e POSTGRES_DB=$POSTGRES_DB \
      -p $POSTGRES_PORT:$POSTGRES_PORT \
      $IMAGE_NAME
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
docker exec -it $CONTAINER_NAME /bin/bash
