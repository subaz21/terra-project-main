
resource "aws_instance" "web" {
  count = var.instance_count  # Use the count variable to control the number of instances

  ami                     = var.ami_id
  instance_type           = var.instance_type
  associate_public_ip_address = true
  subnet_id = count.index % 2 == 0 ? aws_subnet.pubsub1.id : aws_subnet.pubsub2.id
  vpc_security_group_ids = [aws_security_group.pub_sec.id]
  user_data = file("user-data.sh")

  tags = {
    Name = "web-${count.index + 1}"  # Name the instances incrementally
  }
}
