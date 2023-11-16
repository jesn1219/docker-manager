#!/bin/bash

# this script add some options for docker. 
# it prevents nvcc error in container
# https://stackoverflow.com/questions/72932940/failed-to-initialize-nvml-unknown-error-in-docker-after-few-hours

# File path
FILE_PATH="/etc/docker/daemon.json"

# Function to check if jq is installed
function check_and_install_jq() {
    if ! command -v jq &> /dev/null; then
        echo "jq is not installed. Attempting to install jq..."
        sudo apt-get update
        sudo apt-get install -y jq

        if [ $? -ne 0 ]; then
            echo "Failed to install jq. Exiting."
            exit 1
        fi
    else
        echo "jq is already installed."
    fi
}

# Check and install jq
check_and_install_jq

# Temporary file for modifications
TEMP_FILE=$(mktemp)

# Check if the file exists
if [ -f "$FILE_PATH" ]; then
    # Modify the JSON file using jq
    jq '. + {"exec-opts": ["native.cgroupdriver=cgroupfs"]}' "$FILE_PATH" > "$TEMP_FILE" && sudo mv -f "$TEMP_FILE" "$FILE_PATH"
    chmod 0664 /etc/docker/daemon.json

    echo "daemon.json has been updated."
else
    echo "daemon.json does not exist."
fi

sudo service docker restart

