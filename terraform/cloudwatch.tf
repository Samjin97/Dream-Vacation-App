# IAM role for CloudWatch Agent
resource "aws_iam_role" "cw_agent_role" {
  name = "cw-agent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach CloudWatch Agent policy to IAM role
resource "aws_iam_role_policy_attachment" "cw_agent_attach" {
  role       = aws_iam_role.cw_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# IAM instance profile for EC2
resource "aws_iam_instance_profile" "cw_instance_profile" {
  name = "cw-instance-profile"
  role = aws_iam_role.cw_agent_role.name
}

# CloudWatch alarm for CPU utilization
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "dream-ec2-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    InstanceId = aws_instance.dream_ec2.id
  }

  alarm_description = "This metric monitors EC2 CPU utilization above 70%"
  actions_enabled   = false # change to true + SNS topic if you want notifications
}
