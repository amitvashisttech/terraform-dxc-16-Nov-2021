resource "aws_instance" "frontend" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name
  count = 2
  tags = {
    Name = "My-Test-Instance-${count.index}"
  }
}
