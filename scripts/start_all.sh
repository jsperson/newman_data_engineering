#!/bin/bash
CONTAINER_NAME="postgres_data_engineering"
RUNNING_CONTAINER_ID=$(docker ps -q -f name=$CONTAINER_NAME)
if [ -z "$RUNNING_CONTAINER_ID" ]; then
    echo "Container exists but is stopped. Starting..."
    docker start $CONTAINER_NAME
else
    echo "Container is already running."
fi
CONTAINER_NAME="anaconda_data_engineering"
RUNNING_CONTAINER_ID=$(docker ps -q -f name=$CONTAINER_NAME)
if [ -z "$RUNNING_CONTAINER_ID" ]; then
    echo "Container exists but is stopped. Starting..."
    docker start $CONTAINER_NAME
else
    echo "Container is already running."
fi

CONTAINER_NAME="nifi_data_engineering"
RUNNING_CONTAINER_ID=$(docker ps -q -f name=$CONTAINER_NAME)
if [ -z "$RUNNING_CONTAINER_ID" ]; then
    echo "Container exists but is stopped. Starting..."
    docker start $CONTAINER_NAME
else
    echo "Container is already running."
fi
