#provider
variable "aws_region" {
  type        = string 
  description = "region"
  default     = "ap-south-1"
}
# vpc cidr
variable "cidr_vpc" {
  type        = string 
  description = "cidr"
  default     = "10.0.0.0/16" #0 to 65535 -- 65536
}
# pubsub-1
variable "subpub1" {
  type        = string 
  description = "subnet"
  default     = "10.0.1.0/24" #0 to 255 --- 256
}
# pubsub-2
variable "subpub2" {
  type        = string 
  description = "subnet"
  default     = "10.0.2.0/24" #0 to 255 --- 256
}
# pvtsub-1
variable "subpvt1" {
  type        = string 
  description = "subnet"
  default     = "10.0.3.0/24" #0 to 255 --- 256
}
# pvtsub-2
variable "subpvt2" {
  type        = string 
  description = "subnet"
  default     = "10.0.4.0/24" #0 to 255 --- 256
}
# azpub-1
variable "azpub1" {
  type        = string 
  description = "subnet"
  default     = "ap-south-1a" #0 to 255 --- 256
}
# azpub-2
variable "az_sub_pub2" {
  type        = string 
  description = "subnet"
  default     = "ap-south-1b" #0 to 255 --- 256
}
# azpvt-1
variable "az_sub_pvt1" {
  type        = string 
  description = "subnet"
  default     = "ap-south-1a" #0 to 255 --- 256
}
# azpvt-2
variable "az_sub_pvt2" {
  type        = string 
  description = "subnet"
  default     = "ap-south-1b" #0 to 255 --- 256
}
#ami 
variable "ami_id" {
  type        = string 
  description = "ami"
  default     = "ami-0ff30663ed13c2290"
}

# instance type
variable "instance_type" {
  type        = string 
  description = "ami"
  default     = "t2.micro"
}
# db username
variable "db_uname" {
  type        = string 
  description = "user"
  default     = "admin"
}
# pass
variable "db_pass" {
  type        = string 
  description = "pass"
  default     = "Admin123"
}
# db-az
variable "availability_zone_db" {
  type        = string 
  description = "az"
  default     = "ap-south-1a"
}
# instance count
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2  
}
