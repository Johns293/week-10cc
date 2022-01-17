
resource "aws_instance" "public-server1" {
  ami                    = var.ami-id
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1f"
  vpc_security_group_ids = [aws_security_group.SG-HTTP.id]
  subnet_id              = aws_subnet.public-subnet-3.id
  tags = {
  user_data              = file("install_appache.sh")
 
    Name = "public-server1"
  }

}

resource "aws_instance" "public-server2" {
  ami                    = var.ami2-id
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1e"
  vpc_security_group_ids = [aws_security_group.SG-HTTP.id]
  subnet_id              = aws_subnet.public-subnet-2.id
  user_data              = file("install_appache.sh")
  
  tags = {
    Name = "public-server2"
  }
}

