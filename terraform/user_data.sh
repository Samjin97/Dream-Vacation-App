#!/bin/bash
set -euxo pipefail

# Send all output (stdout + stderr) to both the console and a log file
exec > >(tee -a /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "===== USER DATA SCRIPT STARTED at $(date) ====="

# Update system
apt-get update -y
apt-get upgrade -y

# Install prerequisites
apt-get install -y ca-certificates curl gnupg lsb-release

# Setup Docker repository
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Retry loop for apt-get update (in case network isn’t ready)
until apt-get update -y; do sleep 5; done

# Install Docker & Compose
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add ubuntu user to docker group
usermod -aG docker ubuntu || true

# Enable & start Docker
systemctl enable docker
systemctl start docker

# Quick checks (won’t block boot if they fail)
docker --version || true
docker compose version || true

# Install Amazon CloudWatch Agent
apt-get install -y amazon-cloudwatch-agent

# Create CloudWatch Agent configuration
mkdir -p /opt/aws/amazon-cloudwatch-agent/etc/
cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
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
systemctl enable amazon-cloudwatch-agent
systemctl start amazon-cloudwatch-agent

echo "===== USER DATA SCRIPT COMPLETED at $(date) ====="
