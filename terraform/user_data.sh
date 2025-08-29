#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y docker.io

# Enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Install Docker Compose in background
(
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
       -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
) &

# Install CloudWatch Agent in background
(
  sudo apt-get install -y amazon-cloudwatch-agent
  cat <<EOF | sudo tee /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "metrics": { "metrics_collected": { "cpu": { "measurement": ["cpu_usage_idle","cpu_usage_user","cpu_usage_system"], "metrics_collection_interval": 60 } } }
}
EOF
  sudo systemctl enable amazon-cloudwatch-agent
  sudo systemctl start amazon-cloudwatch-agent
) &
