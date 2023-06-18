resource "local_file" "ansible_inventory" {
  content  = <<EOT
[control]
${aws_instance.k8s["k8s-control"].public_ip}
[worker]
${aws_instance.k8s["k8s-worker1"].public_ip}
${aws_instance.k8s["k8s-worker2"].public_ip}
EOT
  filename = "inventory"
}


