variable "region" {
  default = "us-east-2"
}

locals {
  default_name = "${join("-", list(terraform.workspace, "amit"))}"
}


variable "instance_type" {
  type = map
  default = {
    default = "t2.nano"
    dev     = "t2.micro"
    prod    = "t2.large"
    dxc     = "x1.large"
  }
}



variable "instance_count" {
  type = map
  default = {
    default = "1"
    dev     = "2"
    prod    = "5"
    dxc     = "7"

  }
}


variable "key_name" {
  default = "terraform-demo-keypair"
}

variable "pvt_key" {
  default = "/home/amitvashist7/.ssh/amitvashist-terraform.pem"
}

variable "sg_id" {
  default = "sg-07f04bf6c2d8e009c"
}

