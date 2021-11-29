module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-cluster"
  instance_count         = 2

  ami                    = var.ami[var.region]
  instance_type          = "t2.micro"
  key_name               = var.key_name
  monitoring             = true
  vpc_security_group_ids = [var.sg_id]
  subnet_id              = var.subnet_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
