resource "aws_instance" "k8s" {
  #for_each      = toset(["k8s-control", "k8s-worker1", "k8s-worker2"])
  for_each = {
    "k8s-control" = "10.0.1.10",
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

  user_data = format("%s%s", file("./scripts/create_user_ansible.sh"), file("./scripts/containerd.sh"))
  tags = {
    "Name" = each.key
  }
}

# output "EC2_private_ip" {
#   description = "Public IP address of the EC2 instance"
#   value       = aws_instance.k8s.*.private_ip
# }


# output "bootstrap_script" {
#   description = "Public IP address of the EC2 instance"
#   value       = format("%s%s",file("./scripts/create_user_ansible.sh"), file("./scripts/containerd.sh"))
# }