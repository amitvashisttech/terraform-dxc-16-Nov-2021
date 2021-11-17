provider "aws" {
 region = "us-east-2"
}



resource "aws_instance" "frontend" {
  count = 2
  ami           = "ami-0dd0ccab7e2801812"
  instance_type = "t2.micro"
  depends_on = [aws_instance.backend]
}




resource "aws_instance" "backend" {
  count = 1
  ami           = "ami-0dd0ccab7e2801812"
  instance_type = "t2.micro"
}
