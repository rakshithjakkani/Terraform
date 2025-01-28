# --- Security Group for Bastion Host ---
resource "aws_security_group" "bastion_sg" {
  name        = var.sg_name
  description = "Allow SSH access to Bastion Host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_ips
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- Key Pair for Bastion Host ---
resource "aws_key_pair" "bastion_key" {
  key_name   = var.key_name
  public_key = var.public_key
}

# --- EC2 Instance (Bastion Host) ---
# Data source to fetch the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Ubuntu's account ID in AWS Marketplace
  filters = {
    name   = "ubuntu*-amd64-server-*"
  }
}

# EC2 Instance (Bastion Host)
resource "aws_instance" "bastion_host" {
  ami             = data.aws_ami.ubuntu.id   # Use the dynamically fetched Ubuntu AMI ID
  instance_type   = var.instance_type
  key_name        = aws_key_pair.bastion_key.key_name
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.bastion_sg.name]

  associate_public_ip_address = true

  tags = {
    Name = "BastionHost"
  }
}


# --- Output Bastion Host Public IP ---
output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}
