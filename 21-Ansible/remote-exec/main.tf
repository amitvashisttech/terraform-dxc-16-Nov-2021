resource "aws_instance" "frontend" {
  ami                    = "ami-05803413c51f242b7"
  #ami                    = data.aws_ami.myami.id
  instance_type          = lookup(var.instance_type, terraform.workspace)
  count                  = lookup(var.instance_count, terraform.workspace)
  vpc_security_group_ids = [var.sg_id]
  key_name               = var.key_name
  tags = {
    Name = local.default_name
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.pvt_key)
    host        = self.public_ip

  }


  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install python sshpass -y",
    ]

  }



}
