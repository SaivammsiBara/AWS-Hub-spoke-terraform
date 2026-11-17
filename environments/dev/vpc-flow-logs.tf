
# ==========================================
# Account Information
# ==========================================

data "aws_caller_identity" "current" {}


# ==========================================
# CloudWatch Log Group
# ==========================================

resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "/aws/vpc/flowlogs/hub-and-spoke"
  retention_in_days = 7

  tags = {
    Name    = "Hub-Spoke-VPC-Flow-Logs"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# VPC Flow Logs Destroy-Time Delay
# ==========================================

resource "time_sleep" "flow_logs_destroy_delay" {
  destroy_duration = "213s"

  depends_on = [
    aws_cloudwatch_log_group.vpc_flow_logs
  ]
}


# ==========================================
# IAM Trust Policy for VPC Flow Logs
# ==========================================

data "aws_iam_policy_document" "vpc_flow_logs_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values = [
        "arn:aws:ec2:ap-south-1:${data.aws_caller_identity.current.account_id}:vpc-flow-log/*"
      ]
    }
  }
}


# ==========================================
# IAM Role
# ==========================================

resource "aws_iam_role" "vpc_flow_logs" {
  name               = "Hub-Spoke-VPC-FlowLogs-Role"
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_assume_role.json

  tags = {
    Name    = "Hub-Spoke-VPC-FlowLogs-Role"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# IAM Permissions Policy
# ==========================================

resource "aws_iam_role_policy" "vpc_flow_logs_publish" {
  name = "VPC-FlowLogs-CloudWatch-Permissions"
  role = aws_iam_role.vpc_flow_logs.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup"
        ]

        Resource = aws_cloudwatch_log_group.vpc_flow_logs.arn
      },
      {
        Effect = "Allow"

        Action = [
          "logs:DescribeLogGroups"
        ]

        Resource = "*"
      },
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]

        Resource = [
          "${aws_cloudwatch_log_group.vpc_flow_logs.arn}:*"
        ]
      }
    ]
  })
}


# ==========================================
# Production VPC Flow Logs
# ==========================================

resource "aws_flow_log" "production" {
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  iam_role_arn         = aws_iam_role.vpc_flow_logs.arn

  traffic_type = "ALL"
  vpc_id       = module.network.production_vpc_id

  max_aggregation_interval = 60

  depends_on = [
    aws_iam_role_policy.vpc_flow_logs_publish,
    time_sleep.flow_logs_destroy_delay
  ]

  tags = {
    Name    = "Production-VPC-Flow-Logs"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Development VPC Flow Logs
# ==========================================

resource "aws_flow_log" "development" {
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  iam_role_arn         = aws_iam_role.vpc_flow_logs.arn

  traffic_type = "ALL"
  vpc_id       = module.network.development_vpc_id

  max_aggregation_interval = 60

  depends_on = [
    aws_iam_role_policy.vpc_flow_logs_publish,
    time_sleep.flow_logs_destroy_delay
  ]

  tags = {
    Name    = "Development-VPC-Flow-Logs"
    Project = "Hub-and-Spoke"
  }
}


# ==========================================
# Shared Services VPC Flow Logs
# ==========================================

resource "aws_flow_log" "shared_services" {
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  iam_role_arn         = aws_iam_role.vpc_flow_logs.arn

  traffic_type = "ALL"
  vpc_id       = module.network.shared_services_vpc_id

  max_aggregation_interval = 60

  depends_on = [
    aws_iam_role_policy.vpc_flow_logs_publish,
    time_sleep.flow_logs_destroy_delay
  ]

  tags = {
    Name    = "Shared-Services-VPC-Flow-Logs"
    Project = "Hub-and-Spoke"
  }
}
