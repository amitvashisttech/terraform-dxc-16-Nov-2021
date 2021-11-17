provider "aws" {
 region = "us-east-2"
}



resource "aws_instance" "frontend" {
  ami           = "ami-0dd0ccab7e2801812"
  instance_type = "t2.micro"
}




resource "aws_instance" "backend" {
  ami           = "ami-0dd0ccab7e2801812"
  instance_type = "t2.micro"
}
