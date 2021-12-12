data "aws_vpc" "main" {
  tags = {
    Name = "main-${var.env}"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.main.id
  tags = {
    Name = "main-${var.env}-public-*"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.main.id
  tags = {
    Name = "main-${var.env}-private-*"
  }
}