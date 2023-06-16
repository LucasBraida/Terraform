#create VPC, IGW, Route Table, Subnet, Route Table Association and Security Group
provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available-azs" {
  state = "available"
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "My-vpc"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    "Name" = "My-IGW"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    "Name" = "Public-RT"
  }
}

resource "aws_subnet" "my-subnet" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available-azs.names[0]

  tags = {
    "Name" = "My-Subnet"
  }
}

resource "aws_route_table_association" "public-RT-to-subnet" {
  subnet_id      = aws_subnet.my-subnet.id
  route_table_id = aws_route_table.public-RT.id
}

#CHECK WITCH PORTS NEED TO BE ALLOWED TO COMUNICATE BETWEEN THE NODES
resource "aws_security_group" "k8s-SG" {
  name        = "k8s-SG"
  vpc_id      = aws_vpc.my-vpc.id
  description = "Allow HTTP and SSH Access to web-servers"
  
  ingress {
    description = "Allow All Trafic Between Cluster nodes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.1.0/24"]
  }


  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound trafic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    "Name" = "web-server-SG"
  }
}

