terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

# Create VPC - Our private cloud network
resource "aws_vpc" "travel_memory_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "travel-memory-vpc"
  }
}

# Create Internet Gateway - Our connection to the internet
resource "aws_internet_gateway" "travel_memory_igw" {
  vpc_id = aws_vpc.travel_memory_vpc.id

  tags = {
    Name = "travel-memory-igw"
  }
}

# Public Subnet - For our web server (has internet access)
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.travel_memory_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ca-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "travel-memory-public-subnet"
  }
}

# Private Subnet - For our database (no direct internet access)
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.travel_memory_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ca-central-1a"

  tags = {
    Name = "travel-memory-private-subnet"
  }
}

# Route Table for Public Subnet - Allows internet traffic
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.travel_memory_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.travel_memory_igw.id
  }

  tags = {
    Name = "travel-memory-public-rt"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
