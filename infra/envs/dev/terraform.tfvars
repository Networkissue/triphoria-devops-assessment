aws_region = "ap-south-2"

environment = "dev"

vpc_cidr = "10.0.0.0/16"

public_subnet_1 = "10.0.1.0/24"
public_subnet_2 = "10.0.2.0/24"

private_subnet_1 = "10.0.3.0/24"
private_subnet_2 = "10.0.4.0/24"

db_username = "postgres"
db_password = "Password123"

execution_role_arn = "arn:aws:iam::124971231786:role/ecsTaskExecutionRole"

image = "nginx:latest"