data "aws_ami" "myami" {
  most_recent = true
  owners = ["995769830748"]

   filter { 
     name = "name"
     values = ["apache-ami-packer*"]
   }

}
