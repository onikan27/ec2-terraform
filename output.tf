# ====================
# Output
# ====================
output "public_ip" {
  value = aws_eip.test_ip.public_ip
}
