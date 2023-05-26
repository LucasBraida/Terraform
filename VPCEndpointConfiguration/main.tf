resource "aws_instance" "my-webserver" {
  ami                         = "ami-03c7d01cf4dedc891"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.my-kp.key_name
  vpc_security_group_ids     = [aws_security_group.ec2-SG.id]
  subnet_id                   = aws_subnet.my-subnet.id
  iam_instance_profile        = aws_iam_instance_profile.ec2-profile.name
  tags = {
    "Name" = "My-EC2"
  }
}

resource "aws_s3_bucket" "my-s3-bucket" {
  tags = {
    "Name" = "My-bucket"
  }
}

output "S3_name" {
  description = "Name of the S3 Bucket"
  value       = aws_s3_bucket.my-s3-bucket.id
}
output "EC2_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.my-webserver.public_ip
}