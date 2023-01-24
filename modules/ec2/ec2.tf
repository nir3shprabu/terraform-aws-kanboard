locals {
  private_ip = aws_instance.private_instance.private_ip
}
data "template_file" "script" {
  template = file("./templates/kanboard.sh")

  vars = {
    private_ip = local.private_ip
  }
}
resource "aws_key_pair" "genkey" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "public-instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  availability_zone           = var.availability_zone
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [var.public-instance-secgrp]
  subnet_id                   = var.public-subnet-id
  key_name                    = var.key_name
  user_data                   = data.template_file.script.rendered
  tags = {
    Name = var.instance_name
  }
  depends_on = [
    aws_key_pair.genkey
  ]
}

resource "aws_instance" "private_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  availability_zone           = var.availability_zone1
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [var.private-instance-secgrp]
  subnet_id                   = var.private-subnet-id
  key_name                    = var.key_name
  user_data                   = var.private_user_data
  tags = {
    Name = var.private_instance_name
  }
}