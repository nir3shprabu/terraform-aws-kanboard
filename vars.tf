variable "ami_id" {
  default = "ami-03f8756d29f0b5f21"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}
variable "region" {
  default = ""
}
variable "key_name" {
  default = "kanboard-ssh-key"
}
variable "public_key" {
  default = ""
}
variable "availability_zone" {
  default = "us-west-2a"
}
variable "availability_zone1" {
  default = "us-west-2b"
}
variable "instance_name" {
  default = "kanboard-server"
}
variable "private_instance_name" {
  default = "kanboard-database"
}
variable "vpc_name" {
  default = "kanboard-vpc"
}
variable "public-subnets-data" {
  default = [{ name = "public-subnet1", ipsec = "10.0.3.0/24", availability_zone = "us-west-2a" }, { name = "public-subnet2", ipsec = "10.0.4.0/24", availability_zone = "us-west-2a" }]
}
variable "private-subnets-data" {
  default = [{ name = "private-subnet1", ipsec = "10.0.1.0/24", availability_zone = "us-west-2b" }, { name = "private-subnet2", ipsec = "10.0.2.0/24", availability_zone = "us-west-2b" }]
}