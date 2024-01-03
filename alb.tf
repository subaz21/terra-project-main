# ELB
resource "aws_lb" "ALB" {
  name               = "test-lb-tf"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sec.id]
  tags = {
    Name = "ALB-PUB_LB"
  }
   subnet_mapping {
    subnet_id     = aws_subnet.pubsub1.id
  }
  subnet_mapping {
    subnet_id     = aws_subnet.pubsub2.id
  }
}
# target group
resource "aws_lb_target_group" "ALB_target" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALB_target.arn
  }
}


resource "aws_lb_target_group_attachment" "web" {
  count = var.instance_count
  target_group_arn = aws_lb_target_group.ALB_target.arn
  target_id        = aws_instance.web[count.index].id
}
# Create the Application Load Balancer
# module "my_alb" {
#   source = "./modules/alb"  # Specify the path to your ALB module

#   name              = "test-lb-tf"
#   security_groups   = [aws_security_group.pub_sec.id]
#   subnet_ids        = [aws_subnet.pubsub1.id, aws_subnet.pubsub2.id]
#   vpc_id            = aws_vpc.myvpc.id
#   target_group_name = "my-target-group"
# }

# # Create the Target Group
# module "my_target_group" {
#   source = "./modules/target_group"  # Specify the path to your target group module

#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = aws_vpc.myvpc.id
# }

# # Create EC2 Instances and Attach to Target Group
# resource "aws_instance" "web" {
#   count = var.instance_count

#   ami                     = var.ami_id
#   instance_type           = var.instance_type
#   associate_public_ip_address = true
#   subnet_id = count.index  % 2 == 0 ? aws_subnet.pubsub1.id : aws_subnet.pubsub2.id
#   vpc_security_group_ids = [aws_security_group.pvt_sec.id]
#   user_data = file("user-data.sh")

#   tags = {
#     Name = "web-${count.index + 1}"
#   }
# }

# resource "aws_lb_target_group_attachment" "web" {
#   count            = var.instance_count
#   target_group_arn = module.my_target_group.target_group_arn
#   target_id        = aws_instance.web[count.index].id
# }

# resource "aws_lb_listener" "alb_listener" {
#   load_balancer_arn = module.my_alb.alb_arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = module.my_target_group.target_group_arn
#   }
# }

resource "aws_security_group" "alb_sec" {
  name        = "alb"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sec"
  }
}