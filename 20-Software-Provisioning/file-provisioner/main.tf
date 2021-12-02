resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.myami.id
  instance_type          = lookup(var.instance_type, terraform.workspace)
  count                  = lookup(var.instance_count, terraform.workspace)
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name
  tags = {
    Name = local.default_name
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.pvt_key)
    host        = self.public_ip

  }

  provisioner "file" {
    source = "./frontend"
    destination = "~/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ~/frontend/run_frontend.sh",
      "sudo ~/frontend/run_frontend.sh",
    ]

  }



}
