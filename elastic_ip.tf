# ====================
# Elastic IP
# ====================
resource "aws_eip" "test_ip" {
  instance = aws_instance.test_ec2.id
  vpc      = true
}
