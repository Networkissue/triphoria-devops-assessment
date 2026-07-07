resource "aws_ecs_cluster" "main" {
    name = "${var.environment}-cluster"
}

resource "aws_security_group" "ecs" {
    name = "${var.environment}-ecs-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_ecs_task_definition" "app" {
    family = "${var.environment}-app"
    requires_compatibilities = ["FARGATE"]

    network_mode = "awsvpc"

    cpu = 256

    memory = 512

    execution_role_arn = var.execution_role_arn

    container_definitions = jsonencode([
        {
            name = "app"
            image = var.image

            portMappings = [
                {
                    containerPort = 8080
                }
            ]
        }
    ]) 
}

resource "aws_ecs_service" "app" {
    name = "${var.environment}-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.app.arn

    desired_count = 1

    launch_type = "FARGATE"

    network_configuration {
      subnets = var.private_subnets
      security_groups = [aws_security_group.ecs.id]
      assign_public_ip = false
    }
}


