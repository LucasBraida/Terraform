provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available-azs" {
  state = "available"
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_vpc" "wp-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "wp-vpc"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.wp-vpc.id

  tags = {
    "Name" = "My-IGW"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.wp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    "Name" = "Public-RT"
  }
}

resource "aws_route_table" "database-RT" {
  vpc_id = aws_vpc.wp-vpc.id

  tags = {
    "Name" = "Database-RT"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available-azs.names[0]

  tags = {
    "Name" = "public subnet"
  }
}

resource "aws_subnet" "database-subnet" {
  count = 2
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = "10.0.${count.index + 2}.0/24"
  availability_zone       = data.aws_availability_zones.available-azs.names[count.index + 1]

  tags = {
    "Name" = "database subnet ${count.index + 1}"
  }
}

resource "aws_route_table_association" "database-RT-to-subnet" {
  count = length(aws_subnet.database-subnet)
  subnet_id      = aws_subnet.database-subnet[count.index].id
  route_table_id = aws_route_table.database-RT.id
}

# resource "aws_subnet" "database-subnet-1" {
#   vpc_id                  = aws_vpc.wp-vpc.id
#   cidr_block              = "10.0.2.0/24"
#   availability_zone       = data.aws_availability_zones.available-azs.names[1]

#   tags = {
#     "Name" = "database subnet 1"
#   }
# }



# resource "aws_subnet" "database-subnet-2" {
#   vpc_id                  = aws_vpc.wp-vpc.id
#   cidr_block              = "10.0.3.0/24"
#   availability_zone       = data.aws_availability_zones.available-azs.names[2]

#   tags = {
#     "Name" = "database subnet 2"
#   }
# }

resource "aws_route_table_association" "public-RT-to-subnet" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-RT.id
}

# resource "aws_route_table_association" "database-RT-to-database-subnet-1" {
#   subnet_id      = aws_subnet.database-subnet-1.id
#   route_table_id = aws_route_table.database-RT.id
# }

# resource "aws_route_table_association" "database-RT-to-database-subnet-2" {
#   subnet_id      = aws_subnet.database-subnet-2.id
#   route_table_id = aws_route_table.database-RT.id
# }


# resource "aws_security_group" "web-server-SG" {
#   name        = "web-server-SG"
#   vpc_id      = aws_vpc.wp-vpc.id
#   description = "Allow HTTP and SSH Access to web-servers"
#   ingress {
#     description = "Allow HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Allow SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow outbound trafic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }



#   tags = {
#     "Name" = "web-server-SG"
#   }
# }

# resource "aws_key_pair" "my-kp" {
#   key_name   = "my-kp"
#   public_key = file("./acess_key/id_rsa.pub")
# }