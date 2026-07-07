resource "aws_db_subnet_group" "db" {
    name = "${var.environment}-db-subnet"
    subnet_ids = var.private_subnets
}

resource "aws_security_group" "rds" {
    name = "${var.environment}-rds-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr]
    }
}

resource "aws_db_instance" "postgres" {
    identifier = "${var.environment}-postgres"

    engine = "postgres"
    engine_version = "15"

    instance_class = "db.t3.micro"

    allocated_storage = 20

    db_name = "appdb"
    username = var.db_username
    password = var.db_password

    skip_final_snapshot = true

    db_subnet_group_name = aws_db_subnet_group.db.name
    vpc_security_group_ids = [aws_security_group.rds.id]
}

