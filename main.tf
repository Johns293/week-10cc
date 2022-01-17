
resource "aws_vpc" "project-9-vpc" {
  cidr_block       = var.cidr_block-vpc
  instance_tenancy = "default"

  tags = {
    Name = "project-9-vpc "
  }
}

# subnets 

resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.project-9-vpc.id
  cidr_block = var.cidr_block-pri-sub-1
  
  tags = {
    Name = "priavte-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.project-9-vpc.id
  cidr_block = var.cidr_block-pri-sub-2

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.project-9-vpc.id
  cidr_block = var.cidr_block-pub-sub-1

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.project-9-vpc.id
  cidr_block = var.cidr_block-pub-sub-2

  tags = {
    Name = "public-subnet-2"
  }
}

# route-table 
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.project-9-vpc.id
  tags = {
    Name = "web-route-table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.project-9-vpc.id
  tags = {
    Name = "private-route-table"
  }
}

# rout-table assoiciation
resource "aws_route_table_association" "public-route-1-association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route-2-association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-route-1-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
  }

resource "aws_route_table_association" "private-route-2-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
  
}
 # standby public subnet
resource "aws_subnet" "public-subnet-3" {
  vpc_id     = aws_vpc.project-9-vpc.id
  cidr_block = var.cidr_block-pub-sub-3

  tags = {
    Name = "public-subnet-3"
  }
}

resource "aws_route_table_association" "public-route-3-association" {
  subnet_id      = aws_subnet.public-subnet-3.id
  route_table_id = aws_route_table.public-route-table.id
}

# internet gate-way

resource "aws_internet_gateway" "project-9-IGW" {
  vpc_id = aws_vpc.project-9-vpc.id

  tags = {
    Name = "project-8-IGW"
  }
}

resource "aws_route" "public-internet-igw-route" {
  route_table_id            = aws_route_table.public-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.project-9-IGW.id
}
 
