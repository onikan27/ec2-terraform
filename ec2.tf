# ====================
# AMI
# ====================

data "aws_ami" "test_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}

# ====================
# EC2
# ====================

resource "aws_instance" "test_ec2" {
  ami                    = data.aws_ami.test_ami.image_id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.test_subnet.id
  vpc_security_group_ids = [aws_security_group.test_ec2_sg.id]
  key_name               = aws_key_pair.test.id

  tags = {
    Name = "test"
  }
}


# ====================
# Security Group
# ====================

resource "aws_security_group" "test_ec2_sg" {
  name        = "test_ec2_sg"
  description = "ec2_ssh"
  vpc_id      = aws_vpc.test_vpc.id
}

resource "aws_security_group_rule" "inbound_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ip_adress]
  security_group_id = aws_security_group.test_ec2_sg.id
}

resource "aws_security_group_rule" "name" {
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  security_group_id = aws_security_group.test_ec2_sg.id
}


# ====================
# Key
# ====================
resource "aws_key_pair" "test" {
  key_name   = "test"
  public_key = file("./test.pub")
}
