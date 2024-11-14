# To install CLI tools to access AWS, Azure, and GCP
FROM ubuntu

# Add the Non-privileged user
RUN useradd -m sherman && apt update && apt install -y sudo && echo "sherman ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER sherman
WORKDIR /home/sherman

# AWS CLI
RUN sudo apt-get update && sudo apt-get install -y curl unzip && curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && sudo ./aws/install && rm awscliv2.zip

# Azure CLI
RUN sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release && sudo mkdir -p /etc/apt/keyrings && curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null && sudo chmod go+r /etc/apt/keyrings/microsoft.gpg && AZ_DIST=$(lsb_release -cs) && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ ${AZ_DIST} main" | sudo tee /etc/apt/sources.list.d/azure-cli.list && sudo apt update && sudo apt install -y azure-cli

# GCloud CLI
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && sudo apt-get update && sudo apt-get install -y google-cloud-cli