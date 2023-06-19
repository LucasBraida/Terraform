resource "aws_instance" "k8s" {
  for_each = {
    "k8s-master" = "10.0.1.10",
    "k8s-worker1" = "10.0.1.11",
    "k8s-worker2" = "10.0.1.12"
  }
  ami                         = "ami-0261755bbcb8c4a84"
  instance_type               = "t2.medium"
  private_ip                  = each.value
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2-access-kp.key_name
  vpc_security_group_ids      = [aws_security_group.k8s-SG.id]
  subnet_id                   = aws_subnet.my-subnet.id

  user_data = format("%s%s%s%s", file("./scripts/create_user_ansible-1.sh"), file("./access_keys/ansible_id_rsa.pub"), file("./scripts/create_user_ansible-2.sh"), file("./scripts/containerd.sh"))
  tags = {
    "Name" = each.key
  }
}

output "EC2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = [for node in aws_instance.k8s : node.public_ip]
}

output "bootstrap_script" {
  value = format("%s%s%s%s", file("./scripts/create_user_ansible-1.sh"), file("./access_keys/ansible_id_rsa.pub"), file("./scripts/create_user_ansible-2.sh"), file("./scripts/containerd.sh"))
}