output "public-subnet-id" {
  value = aws_subnet.public-subnet[1].id
}
output "private-subnet-id" {
  value = aws_subnet.private-subnet[1].id
}
output "public-security" {
  value = aws_security_group.public-security.id
}
output "private-security" {
  value = aws_security_group.private-security.id
}

