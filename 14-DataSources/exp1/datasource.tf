provider "aws" {
  version =">3.10"
  region = var.region
}

variable "region" {
 default = "us-east-2"
}


data "aws_ami" "myami" {
  most_recent = true
  owners = ["amazon"]

   filter { 
     name = "name"
     values = ["amzn2-ami-hvm*"]
   }

}

/*
resource "aws_instance" "frontend" {
  ami           = "ami-0dd0ccab7e2801812"
  instance_type = "t2.micro"
  count = 2 
}
*/

resource "aws_instance" "frontend" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
  count = 2
  tags = {
    Name = "My-Test-Instance-${count.index}"
  }
}
