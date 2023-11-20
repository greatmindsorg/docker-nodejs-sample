module "ecs_service" {
  source = "terraform-aws-modules/ecs/aws//modules/service"

  name        = "nginx-service"
  cluster_arn = var.ecs_cluster_arn

  cpu    = 1024
  memory = 4096

  enable_execute_command = true

  container_definitions = {

    nginx = {
      cpu       = 512
      memory    = 1024
      essential = true
      image     = "docker.io/nginx:latest"
      port_mappings = [
        {
          name          = "nginx"
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]

      readonly_root_filesystem = false

      #dependencies = [{
        # containerName = "fluent-bit"
        # condition     = "START"
      #}]

      enable_cloudwatch_logging = false

      linux_parameters = {
        capabilities = {
          drop = [
            "NET_RAW"
          ]
        }
      }

      memory_reservation = 100
    }

    # load_balancer = {
    #     service = {
    #         target_group_arn = ""
    #         container_name   = ""
    #         container_port   = 80
    #     }
    # }
  }

  subnet_ids = ["subnet-0399115dca3811023", "subnet-070cafb4a16baba0f", "subnet-0ce6c7542f234c843"]
  security_group_rules = {
    ingress = {
      type                     = "ingress"
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      description              = "Ingress traffic from VPC"
      #source_security_group_id = ""
      cidr_blocks = ["10.40.0.0/16"]
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "dev-nginx-service"
  }
}

