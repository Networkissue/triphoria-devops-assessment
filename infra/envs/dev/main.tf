provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"

  environment = var.environment
  aws_region  = var.aws_region

  vpc_cidr         = var.vpc_cidr
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2
}

module "rds" {
  source = "../../modules/rds"

  environment     = var.environment
  private_subnets = module.network.private_subnets

  vpc_id   = module.network.vpc_id
  vpc_cidr = var.vpc_cidr

  db_username = var.db_username
  db_password = var.db_password
}

module "ecs" {
  source = "../../modules/ecs"

  environment     = var.environment
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets

  execution_role_arn = var.execution_role_arn

  image = var.image
}


