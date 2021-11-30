resource "aws_instance" "frontend" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
  count = 2
  tags = {
    Name = "My-Test-Instance-${count.index}"
  }
}
