# tf file for create vpc and put the EKS cluster in it

variable "region" {
  default     = "cn-northwest-1"
  description = "AWS region"
}

variable "general_name" {
  default     = "cicdeks"
  description = "general name"
}

locals {
  vpc_name = "${var.general_name}-vpc"
  cluster_name = "${var.general_name}-cluster-${random_string.suffix.result}"
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 4
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = local.vpc_name
  cidr                 = "10.98.0.0/18"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.98.1.0/24", "10.98.2.0/24", "10.98.3.0/24"]
  public_subnets       = ["10.98.4.0/24", "10.98.5.0/24", "10.98.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
