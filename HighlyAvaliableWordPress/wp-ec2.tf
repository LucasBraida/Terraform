resource "aws_security_group" "wp-ec2-sg" {
  name        = "wp-ec2-sg"
  vpc_id      = aws_vpc.wp-vpc.id
  description = "Allow HTTP and SSH Access to web-servers"
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    "Name" = "wp-ec2-sg"
  }
}

resource "aws_key_pair" "ec2-kp" {
  key_name   = "ec2-kp"
  public_key = file("./acess_key/id_rsa.pub")
}

resource "aws_instance" "wp-ec2" {
  ami                         = "ami-03c7d01cf4dedc891"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2-kp.key_name
  security_groups             = [aws_security_group.wp-ec2-sg.id]
  subnet_id                   = aws_subnet.public-subnet.id

  # user_data = file("./bootstrap_script.sh")
  tags = {
    "Name" = "wp-ec2"
  }
}

output "EC2_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.wp-ec2.public_ip
}