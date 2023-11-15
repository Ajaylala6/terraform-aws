#CREATE AWS-VPC
resource "aws_vpc" "Tf-food" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Tf-food"
  }
}


##CREATE AWS-SUBNET-1
resource "aws_subnet" "tf-food-subnet-1" {
  vpc_id     = aws_vpc.Tf-food.id
  cidr_block = "192.168.0.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Tf-pub-sn"
  }
}

###CREATE AWS-SUBNET-2
resource "aws_subnet" "tf-food-subnet-2" {
  vpc_id     = aws_vpc.Tf-food.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Tf-pub-sub-1"
  }
}