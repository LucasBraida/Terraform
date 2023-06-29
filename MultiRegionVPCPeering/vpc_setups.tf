provider "aws" {
  region = var.master-region
  alias = "region-master"
}

provider "aws" {
  region = var.worker-region
  alias = "worker-region"
}

