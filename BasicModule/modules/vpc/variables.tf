variable "region" {
  type = string
  default = "us-east-1"
}

variable "vpc" {
  type = object({
    cidr_block = string
  })

  default = {
    cidr_block = "10.0.0.0/16"
  }
}

variable "subnet" {
  type = object({
    cidr_block = string
  })

  default = {
    cidr_block = "10.0.1.0/24"
  }
}