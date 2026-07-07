variable "aws_region" {
    type = string
}
variable "environment" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "public_subnet_1" {
    type = string
}
variable "public_subnet_2" {
    type = string
}

variable "private_subnet_1" {
    type = string
}
variable "private_subnet_2" {
    type = string
}

variable "db_username" {
    type = string
}
variable "db_password" {
    type = string
}

variable "execution_role_arn" {
    type = string
}
variable "image" {
    type = string
}