resource "aws_db_instance" "main" {
  name                   = "${title(var.env)}Cerebrum"
  identifier             = "${var.env}-cerebrum"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  engine                 = "mariadb"
  engine_version         = "10.5"
  username               = "master"
  password               = random_password.master_password.result
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id, aws_security_group.ecs_sg.id]
  parameter_group_name   = aws_db_parameter_group.main.name
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.env}-cerebrum"
  subnet_ids = data.aws_subnet_ids.private.ids

  tags = {
    Name = "${var.env}-cerebrum DB subnet group"
  }
}

resource "aws_db_parameter_group" "main" {
  name   = "${var.env}-cerebrum"
  family = "mariadb10.5"
}

resource "aws_secretsmanager_secret" "rds_main" {
  name = "${var.env}/rds-db-credentials/${aws_db_instance.main.id}"
}

resource "aws_secretsmanager_secret_version" "rds_main" {
  secret_id = aws_secretsmanager_secret.rds_main.id
  secret_string = jsonencode({
    "dbInstanceIdentifier" = aws_db_instance.main.id
    "engine"               = aws_db_instance.main.engine
    "database"             = aws_db_instance.main.name
    "host"                 = split(":", aws_db_instance.main.endpoint)[0]
    "port"                 = split(":", aws_db_instance.main.endpoint)[1]
    "resourceId"           = aws_db_instance.main.resource_id
    "username"             = aws_db_instance.main.username
    "password"             = random_password.master_password.result
  })
}

resource "random_password" "master_password" {
  length           = 32
  special          = true
  override_special  = "!#$%^&*()-_=+[]{}<>:?"
}