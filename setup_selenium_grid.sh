#!/bin/bash

# Variables
SELENIUM_HUB_VERSION="3.141.59"
SELENIUM_NODE_CHROME_VERSION="3.141.59"
SELENIUM_NODE_FIREFOX_VERSION="3.141.59"
HUB_PORT=4444

# Pull the necessary Docker images
echo "Pulling Selenium Hub Docker image..."
docker pull selenium/hub:$SELENIUM_HUB_VERSION

echo "Pulling Selenium Node Chrome Docker image..."
docker pull selenium/node-chrome:$SELENIUM_NODE_CHROME_VERSION

echo "Pulling Selenium Node Firefox Docker image..."
docker pull selenium/node-firefox:$SELENIUM_NODE_FIREFOX_VERSION

# Start the Selenium Grid Hub
echo "Starting Selenium Grid Hub..."
docker run -d -p $HUB_PORT:4444 --name selenium-hub selenium/hub:$SELENIUM_HUB_VERSION

# Start Selenium Node Chrome
echo "Starting Selenium Node Chrome..."
docker run -d --link selenium-hub:hub selenium/node-chrome:$SELENIUM_NODE_CHROME_VERSION

# Start Selenium Node Firefox
echo "Starting Selenium Node Firefox..."
docker run -d --link selenium-hub:hub selenium/node-firefox:$SELENIUM_NODE_FIREFOX_VERSION

# Output the status of the Docker containers
echo "Docker containers running:"
docker ps

# Check if the Selenium Grid Hub is up and running
echo "Waiting for Selenium Grid Hub to be ready..."
until $(curl --output /dev/null --silent --head --fail http://localhost:$HUB_PORT/grid/console); do
    printf '.'
    sleep 1
done

echo "Selenium Grid Hub is ready and running at http://localhost:$HUB_PORT/grid/console"

