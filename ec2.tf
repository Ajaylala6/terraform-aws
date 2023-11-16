# Security Group
resource "aws_security_group" "tf-food-pub-sg" {
  name        = "food-web-sg"
  description = "Allow SSH & HTTP traffic"
  vpc_id      = aws_vpc.Tf-food.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "food-web-sg"
  }
}

##EC2 Instance
resource "aws_instance" "Tf-food-pub-ec2" {
  ami           = "ami-0a7cf821b91bcccbc"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tf-food-subnet-1.id
  key_name = "Lala-key"
  vpc_security_group_ids = [aws_security_group.tf-food-pub-sg.id]
  user_data = file("webapp.sh")

  tags = {
    Name = "food-server"
  }
}
