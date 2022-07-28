data "aws_security_group" "ec2_sg" {
    filter {
      name = "tag:Name"
      values = ["ansible_server"]
    }
  
}
data "aws_vpc" "labvpc" {
    filter {
    name   = "tag:Name"
    values = ["lab_vpc"]
  }

}
  
