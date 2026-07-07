variable "environment" {
    type = string
}
variable "vpc_id" {
    type = string
}

variable "private_subnets" {
    type = list(string)
}

variable "execution_role_arn" {
    type = string
}

variable "image" {
    type = string
}