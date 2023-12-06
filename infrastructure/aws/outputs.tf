output "lambda_url" {
    description = "The URL of the lambda"
    value       = aws_lambda_function_url.demo_url.function_url
}