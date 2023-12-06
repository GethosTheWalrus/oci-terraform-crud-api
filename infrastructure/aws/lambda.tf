data "aws_iam_policy_document" "demo_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "demo_iam" {
  name               = "demo_iam"
  assume_role_policy = data.aws_iam_policy_document.demo_assume_role.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]
}

data "archive_file" "archive" {
  type        = "zip"
  source_dir = "../api/dist"
  output_path = "../archives/Archive.zip"
}

resource "aws_lambda_function" "demo_lambda" {
  filename      = "../archives/Archive.zip"
  function_name = "demo_lambda"
  role          = aws_iam_role.demo_iam.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.archive.output_base64sha256

  runtime = "nodejs20.x"

  environment {
    variables = {
      INFRA = "aws",
      DEPLOYMENT = "serverless"
    }
  }
}

resource "aws_lambda_function_url" "demo_url" {
  function_name      = aws_lambda_function.demo_lambda.function_name
#   qualifier          = "demo_url"
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}