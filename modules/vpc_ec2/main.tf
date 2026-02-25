#VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "redhat-vpc"
  }
}

#subnets
#public subnet 
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

    tags = {
        Name = "redhat-public-subnet"
    }
}
#private subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr

    tags = {
        Name = "redhat-private-subnet"
    }
}

#Route Tables 
#public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "redhat-public-rt"
  }
}

#route table association for public subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}



#rpivate route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

    tags = {
        Name = "redhat-private-rt"
    }
}

#route table association for private subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

    tags = {
        Name = "redhat-igw"
    }
}

#internet gateway attachment
resource "aws_internet_gateway_attachment" "igw_attach" {
  vpc_id             = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.igw.id
}