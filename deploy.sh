#!/bin/bash

# Load environment variables
STAGE=${1:-dev}
CONFIG_FILE="configs/${STAGE}_config"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Config file not found! Using defaults."
fi

echo "[Step 1] Updating packages..."
sudo apt update -y

echo "[Step 2] Installing Java 21..."
sudo apt install -y openjdk-21-jdk maven git

echo "[Step 3] Cloning repository..."
git clone https://github.com/techeazy-consulting/techeazy-devops.git
cd techeazy-devops

echo "[Step 4] Building project with Maven..."
mvn clean package

echo "[Step 5] Running application..."
nohup java -jar target/techeazy-devops-0.0.1-SNAPSHOT.jar > app.log 2>&1 &

echo "[Step 6] Scheduling shutdown in 60 minutes..."
sudo shutdown -h +60
