# Security Group for Web Server - The bouncer for our front door
resource "aws_security_group" "web_sg" {
  name        = "travel-memory-web-sg"
  description = "Allow HTTP, HTTPS, and SSH from my IP only"
  vpc_id      = aws_vpc.travel_memory_vpc.id

  # Allow HTTP from anywhere (users accessing website)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS from anywhere (secure website access)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH ONLY from your specific IP (SECURE!)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.219.239.186/32"]  # ONLY YOU can SSH in!
  }

  # Allow all outbound traffic (web server needs to download packages)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "travel-memory-web-sg"
  }
}

# Security Group for Database - The vault door
resource "aws_security_group" "db_sg" {
  name        = "travel-memory-db-sg"
  description = "Allow MongoDB only from web server"
  vpc_id      = aws_vpc.travel_memory_vpc.id

  # Allow MongoDB ONLY from web server security group
  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  tags = {
    Name = "travel-memory-db-sg"
  }
}
