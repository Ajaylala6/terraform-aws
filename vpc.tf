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

# Create Pvt Subnet -A
resource "aws_subnet" "tf-food-pvt-sn-A" {
  vpc_id     = aws_vpc.Tf-food.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "food-private-subnet-A"
  }
}

# Create Pvt Subnet -B
resource "aws_subnet" "tf-food-pvt-sn-B" {
  vpc_id     = aws_vpc.Tf-food.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "ap-south-1c"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "food-private-subnet-B"
  }
}



##CREATE INTERNET_GATEWAY
resource "aws_internet_gateway" "tf-food-igw" {
  vpc_id = aws_vpc.Tf-food.id

  tags = {
    Name = "food-igw"
  }
}

# Create Public Route Table
resource "aws_route_table" "tf-food-pub-rt" {
  vpc_id = aws_vpc.Tf-food.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-food-igw.id
  }

  tags = {
    Name = "food-pub-rt"
  }
}

# Create Private Route Table
resource "aws_route_table" "tf-food-pvt-rt" {
  vpc_id = aws_vpc.Tf-food.id

  tags = {
    Name = "food-prv-rt"
  }
}

# Create Public Associations 
resource "aws_route_table_association" "tf-food-pub-asc-A" {
  subnet_id      = aws_subnet.tf-food-subnet-1.id
  route_table_id = aws_route_table.tf-food-pub-rt.id
}

resource "aws_route_table_association" "tf-food-pub-asc-B" {
  subnet_id      = aws_subnet.tf-food-subnet-2.id
  route_table_id = aws_route_table.tf-food-pub-rt.id
}

# Create Private Associations
resource "aws_route_table_association" "tf-food-pvt-asc-A" {
  subnet_id      = aws_subnet.tf-food-pvt-sn-A.id
  route_table_id = aws_route_table.tf-food-pvt-rt.id
}

resource "aws_route_table_association" "tf-food-pvt-asc-B" {
  subnet_id      = aws_subnet.tf-food-pvt-sn-B.id
  route_table_id = aws_route_table.tf-food-pvt-rt.id
}
