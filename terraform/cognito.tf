# resource "aws_cognito_user_pool" "pool" {
#   name = "mypool"
# }

# resource "aws_cognito_user_pool_client" "client" {
#   name                                 = "client"
#   allowed_oauth_flows_user_pool_client = true
#   generate_secret                      = false
#   allowed_oauth_scopes                 = ["aws.cognito.signin.user.admin", "email", "openid", "profile"]
#   allowed_oauth_flows                  = ["implicit", "code"]
#   explicit_auth_flows                  = ["ADMIN_NO_SRP_AUTH", "USER_PASSWORD_AUTH"]
#   supported_identity_providers         = ["COGNITO"]

#   user_pool_id  = aws_cognito_user_pool.pool.id
#   callback_urls = ["https://example.com"]
#   logout_urls   = ["https://mitch-api.com"]
# }

# resource "aws_cognito_user" "example" {
#   user_pool_id = aws_cognito_user_pool.pool.id
#   username     = "mitch"
#   password     = "Test@123"
# }


# resource "aws_api_gateway_authorizer" "demo" {
#   name          = "my_apig_authorizer2"
#   rest_api_id   = aws_api_gateway_rest_api.my_api.id
#   type          = "COGNITO_USER_POOLS"
#   provider_arns = [aws_cognito_user_pool.pool.arn]
# }
