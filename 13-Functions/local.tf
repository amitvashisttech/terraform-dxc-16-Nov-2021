provider "aws" {
  version = "3.20"
  region  = "us-east-2"
}


provider "aws" {
  version = "3.20"
  region  = "us-west-2"
  alias   = "us-west-2"
}

variable "zones_east" {
  default = ["us-east-2a", "us-east-2b"]
}

variable "zones_west" {
  default = ["us-west-2a", "us-west-2c"]
}

variable "multi-region-deployment" {
  default = false
}

variable "project-name" {
  default = "Terraform-Demo"
}

variable "project-name-2" {
  default = "Test-Demo"
}


variable "project-name-3" {
  default = "West-Production-Nodes"
}

locals {
  default_frontend_name = "${join("-", tolist([var.project-name, "Frontend"]))}"
  default_backend_name  = "${join("-", tolist([var.project-name, "Backend"]))}"
  west_frontend_name    = "${join("-", tolist([var.project-name-3, "Frontend"]))}"
  west_backend_name     = "${join("-", tolist([var.project-name-3, "Backend"]))}"
}


locals {
  some_tags = {
    Owner   = "DevOps Team"
    Project = "Initial Demo Project"
    Server  = "Backend"
    Name    = local.west_backend_name
  }
}


locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "tags" {
  type = list 
  default = ["app-dev-first", "app-dev-second"]
}

resource "aws_key_pair" "loginkey" {
  key_name = "terrafrom-login-demo-key"
  #pubic_key = "xhahahahahahahahahahaahahahhshahshahs"
  public_key = file("/home/amitvashist7/.ssh/id_rsa.pub")
}


resource "aws_instance" "east_frontend" {
  ami               = "ami-0dd0ccab7e2801812"
  instance_type     = "t2.micro"
  availability_zone = var.zones_east[count.index]
  count             = 2
  key_name          = aws_key_pair.loginkey.key_name
  depends_on        = [aws_instance.east_backend]
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    #Name = "${join("-", list(var.project-name, "Frontend"))}-${count.index + 1}"
    #Name = "${join("-", tolist([var.project-name, "Frontend"]))}-${count.index + 1}"
    #Name = local.default_frontend_name
    Name = element(var.tags,count.index)
  }
}

resource "aws_instance" "west_frontend" {
  ami               = "ami-00be885d550dcee43"
  instance_type     = "t2.micro"
  availability_zone = var.zones_west[count.index]
  count             = var.multi-region-deployment ? 2 : 0
  depends_on        = [aws_instance.west_backend]
  provider          = aws.us-west-2
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = local.west_frontend_name
  }

}


resource "aws_instance" "east_backend" {
  ami               = "ami-0dd0ccab7e2801812"
  instance_type     = "t2.micro"
  availability_zone = var.zones_east[count.index]
  count             = 2
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = local.default_backend_name
  }

}


resource "aws_instance" "west_backend" {
  ami               = "ami-00be885d550dcee43"
  instance_type     = "t2.micro"
  availability_zone = var.zones_west[count.index]
  count             = var.multi-region-deployment ? 2 : 0
  provider          = aws.us-west-2
  lifecycle {
    prevent_destroy = false
  }
  tags = local.some_tags
 
}

output "PublicIP_East_Frontend" {
  value = aws_instance.east_frontend.*.public_ip
}

output "PublicIP_East_Backend" {
  value = aws_instance.east_backend.*.public_ip
}



output "tag_name" {
  value = concat(aws_instance.east_backend.*.tags.Name, aws_instance.east_frontend.*.tags.Name)
}

output "timestamp" {
  value = local.time
}


output "timestamp2" {
  value = timestamp()
}
