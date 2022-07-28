resource "aws_security_group" "rds_server" {
  name        = "rds-server"
  description = "Allow connection for private inbound traffic"
  vpc_id      = data.aws_vpc.labvpc.id

  ingress {
    description      = "allow port 3306"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    #cidr_blocks      = ["192.168.1.0/24"] 
    security_groups = [data.aws_security_group.ec2_sg.id]
  }

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    tags = {
      "Name" = "rds-sg"
    }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id     = data.aws_vpc.labvpc.id     
  cidr_block = "192.168.4.0/24"
  availability_zone = "eu-west-1b"


  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = data.aws_vpc.labvpc.id
  cidr_block = "192.168.5.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "private-subnet2"
  }
}

resource "aws_db_subnet_group" "db_subnet" {
name = "db_subnet_group"
subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]
}