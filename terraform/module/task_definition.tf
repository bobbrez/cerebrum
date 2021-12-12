resource "aws_ecs_task_definition" "hello_world" {
  family                   = "hello-world-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  container_definitions = templatefile("${path.module}/task_definition.json.tpl", { REPOSITORY_URL = "${aws_ecr_repository.worker.repository_url}" })
}