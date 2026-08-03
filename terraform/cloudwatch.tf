resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "dream-app-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods   = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "Triggers when average CPU exceeds 70% for 4 minutes"

  dimensions = {
    InstanceId = aws_instance.dream_app_server.id
  }
}
