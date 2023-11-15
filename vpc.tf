#CREATE AWS-VPC
resource "aws_vpc" "Tf-food" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Tf-food"
  }
}
