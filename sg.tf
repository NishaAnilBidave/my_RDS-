resource "aws_security_group" "rds_server" {
  name        = "rds-server"
  description = "Allow connection for private inbound traffic"
  vpc_id      = data.aws_vpc.talent-academy.id

  ingress {
    description      = "allow port 80"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["182.70.64.92/32"]
  }
}

data "lab_vpc" "talent-academy" {
    filter {
    name   = "tag:Name"
    values = ["lab_vpc"]
  }

}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.lab_vpc.id     
  cidr_block = "182.70.1.0/24"
  availability_zone = "eu-west-1b"


  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.lab_vpc.id
  cidr_block = "182.70.2.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "private-subnet2"
  }
}

resource "aws_db_subnet_group" "db-subnet" {
name = "db_subnet_group"
subnet_ids = ["${aws_subnet.private_subnet1.id}", "${aws_subnet.private_subnet2.id}"]
}