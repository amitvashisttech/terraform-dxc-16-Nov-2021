terraform { 
 required_providers {
   aws = {
      version = ">=3.63.0, <=3.65.0"
    }
  }

}


provider "aws" {
 region = "us-east-2"

}

resource "aws_instance" "us_east_frontend" {
  ami           = "ami-0dd0ccab7e2801812"
  instance_type = "t2.micro"
}
