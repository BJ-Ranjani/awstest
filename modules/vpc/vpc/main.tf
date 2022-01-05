resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.vpc_tags,
  )
}
resource "aws_vpc_ipv4_cidr_block_association" "this" {
  count = var.create_vpc && length(var.secondary_cidr_blocks) > 0 ? length(var.secondary_cidr_blocks) : 0

  vpc_id = aws_vpc.this[0].id

  cidr_block = element(var.secondary_cidr_blocks, count.index)
}
resource "aws_flow_log" "main" {
  log_destination = module.log_group.cloudwatch_log_group_arn
  iam_role_arn    = aws_iam_role.main.arn
  vpc_id          = aws_vpc.this[0].id
  traffic_type    = "ALL"
}

#
# CloudWatch
#

module "log_group" {
  source = "../../../cloudwatch/modules/log-group/"

  name              = "vpc-flow-logs-${var.name}"
  retention_in_days = 365

}

#
# IAM
#

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "role_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role" "main" {
  name               = "vpc-flow-logs-role-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy" "main" {
  name   = "vpc-flow-logs-role-policy-${var.name}"
  role   = aws_iam_role.main.id
  policy = data.aws_iam_policy_document.role_policy.json
}
