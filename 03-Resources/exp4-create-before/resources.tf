provider "aws" {
 region = "us-east-2"
}



resource "aws_instance" "frontend" {
  count = 1
  # Amazon Linux
   ami           = "ami-0dd0ccab7e2801812"
  # Ubuntu 16.04 
  # ami   = "ami-05803413c51f242b7"
  instance_type = "t2.micro"

 lifecycle {
   create_before_destroy = true
 }
}

