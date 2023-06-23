provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available-azs" {
  state = "available"
}

module "wp-vpc-simple" {
  source = "terraform-aws-modules/vpc/aws"

  name = "wp-vpc-simple"
  cidr = "10.0.0.0/16"

  azs             = [data.aws_availability_zones.available-azs.names[0], data.aws_availability_zones.available-azs.names[1]]
  private_subnets = ["10.0.1.0/24"]
  private_subnet_names = ["DB subnet"]
  public_subnets  = ["10.0.101.0/24"]
  database_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
  database_subnet_names = ["DB subnet1", "DB subnet2"]

  enable_nat_gateway = false
  enable_vpn_gateway = true


  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}