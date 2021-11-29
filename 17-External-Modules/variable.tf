
variable "region" { 
  default = "us-east-2"
}

variable "key_name" { 
  default = "terraform-demo-keypair"
}

variable "sg_id" { 
  default = "sg-07f04bf6c2d8e009c"
}

variable "subnet_id" { 
  default = "subnet-0c9f38ef5e8a1b2cb"
}

variable "ami" { 
  type = map
  default = { 
  "us-east-1" = "ami-0947d2ba12ee1ff75"
  "us-east-2" = "ami-0dd0ccab7e2801812"
  "us-west-1" = "ami-0e4035ae3f70c400f"
  "ap-south-1" = "ami-0e306788ff2473ccb"
  }
}
