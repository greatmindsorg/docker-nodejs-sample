variable "env" {
  type    = string
  default = "dev"
}

variable "ecs_cluster_arn" {
  type    = string
  default = "arn:aws:ecs:us-east-2:700429856186:cluster/dev-ecs-fargate"
}