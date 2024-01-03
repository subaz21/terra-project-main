resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  //db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.db_uname
  password             = var.db_pass
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.pvt_sec.id]
  availability_zone = var.availability_zone_db
  db_subnet_group_name = aws_db_subnet_group.dbsubnet.id
  tags = {
    "Name" = "terraform_db"
  }
}

resource "aws_db_subnet_group" "dbsubnet" {
  name        = "my-db-subnet-group"
  description = "My DB Subnet Group"
  subnet_ids  = [aws_subnet.pvtsub1.id, aws_subnet.pvtsub2.id]
}

