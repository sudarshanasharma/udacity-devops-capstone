Upload_docker.sh

#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath='sudarshanas/capstone'

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login 
docker tag capstone sudarshanas/capstone:latest

# Step 3:
# Push image to a docker repository
docker push sudarshanas/capstone:latest
