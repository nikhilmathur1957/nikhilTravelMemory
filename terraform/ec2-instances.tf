# Web Server EC2 Instance - Lives in public subnet
resource "aws_instance" "web_server" {
  ami                    = "ami-00e13aa668f17b8e7"  # Amazon Linux 2023
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "nikhilm"  # Your existing key pair

  # This ensures the instance gets a public IP
  associate_public_ip_address = true

  tags = {
    Name = "travel-memory-web-server"
  }

  # Basic setup script
  user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              EOF
}

# Database Server EC2 Instance - Lives in private subnet  
resource "aws_instance" "db_server" {
  ami                    = "ami-00e13aa668f17b8e7"  # Amazon Linux 2023
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  key_name               = "nikhilm"  # Your existing key pair

  # No public IP for database - it's private!
  associate_public_ip_address = false

  tags = {
    Name = "travel-memory-db-server"
  }

  # Basic setup script
  user_data = <<-EOF
              #!/bin/bash
              sudo dnf update -y
              EOF
}
