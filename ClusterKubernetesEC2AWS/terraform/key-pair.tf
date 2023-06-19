#create a key pair and add to the access_keys folder
resource "aws_key_pair" "ec2-access-kp" {
  key_name   = "my-kp"
  public_key = file("./access_keys/ec2_id_rsa.pub")
}