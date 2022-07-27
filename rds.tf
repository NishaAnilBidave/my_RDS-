resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "my_db"
  username             = "main"
  password             = "main123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = "$(aws_db_subnet_group.db-subnet.name)"
}

resource "aws_vpc" "lab_vpc" {
  cidr_block = "182.70.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}


