#!/bin/bash
# Update and install Docker
sudo apt-get update -y
sudo apt-get install -y docker.io curl

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add ubuntu user to docker group so docker commands work without sudo
sudo usermod -aG docker ubuntu

# Wait a few seconds for group change to apply
sleep 5

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
     -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify docker and docker-compose installation
/usr/bin/docker --version
/usr/local/bin/docker-compose --version

# Install Amazon CloudWatch Agent
sudo apt-get install -y amazon-cloudwatch-agent

# Create CloudWatch Agent configuration
sudo mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/
cat <<EOF | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "metrics": {
    "metrics_collected": {
      "cpu": {
        "measurement": [
          "cpu_usage_idle",
          "cpu_usage_user",
          "cpu_usage_system"
        ],
        "metrics_collection_interval": 60
      }
    }
  }
}
EOF

# Enable and start CloudWatch Agent
sudo systemctl enable amazon-cloudwatch-agent
sudo systemctl start amazon-cloudwatch-agent

# Optional: Test docker works for ubuntu user
sudo -u ubuntu /usr/bin/docker run hello-world || true

