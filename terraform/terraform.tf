terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Specifies the official Terraform registry as the source for the AWS provider
      version = "~> 5.0"        # Use version 3.x.x of the AWS provider; adjust as needed based on compatibility and features
    }
  }

  backend "remote" {
    organization = "mfkimbell"

    workspaces {
      name = "dev-react"
    }
  }
}

# Configure the AWS provider
provider "aws" {

  region = "us-east-1" # Specifies the AWS region for your resources; change this as per your requirements
  # Optionally, you can specify credentials here, but it's often better to use
  # environment variables or other methods for managing AWS credentials securely.
}
