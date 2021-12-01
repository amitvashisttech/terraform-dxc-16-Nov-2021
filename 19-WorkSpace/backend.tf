terraform { 
  backend "s3" {
    bucket = "terraform-demo-av-30nov2021"
    key = "terraform-backend-av/terraform.tfstate" 
    region = "us-east-2"
  }
}


