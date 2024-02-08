data "archive_file" "lambda_package_post" {
  type        = "zip"
  source_file = "./lambdas/test-post.js"
  output_path = "test-post.zip"
}

data "archive_file" "lambda_package_get" {
  type        = "zip"
  source_file = "./lambdas/test-get.js"
  output_path = "test-get.zip"
}

resource "aws_lambda_function" "html_lambda_post" {
  filename         = "test-post.zip"
  function_name    = "myLambdaFunctionPost"
  role             = aws_iam_role.lambda_role.arn
  handler          = "test-post.handler"
  runtime          = "nodejs14.x"
  source_code_hash = data.archive_file.lambda_package_post.output_base64sha256
}

resource "aws_lambda_function" "html_lambda_get" {
  filename         = "test-get.zip"
  function_name    = "myLambdaFunctionGet"
  role             = aws_iam_role.lambda_role.arn
  handler          = "test-get.handler"
  runtime          = "nodejs14.x"
  source_code_hash = data.archive_file.lambda_package_get.output_base64sha256
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


//permissions
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.html_lambda_post.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.my_api.execution_arn}/*/*/*"
}
