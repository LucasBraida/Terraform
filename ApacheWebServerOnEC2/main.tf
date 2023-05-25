resource "aws_instance" "my-webserver" {
  ami                         = "ami-03c7d01cf4dedc891"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my-kp.key_name
  security_groups             = [aws_security_group.web-server-SG.id]
  subnet_id                   = aws_subnet.my-subnet.id

  user_data = file("./bootstrap_script.sh")
  tags = {
    "Name" = "My-WebServer"
  }
}

output "EC2_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.my-webserver.public_ip
}