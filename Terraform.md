# Terraform Infrastructure Deployment Guide

## Infrastructure Overview
This Terraform configuration deploys a complete MERN stack application on AWS with production-grade architecture.

## Architecture
[Internet] → [Public Subnet: Web Server] → [Private Subnet: Database Server]
↑ ↑ ↑
Load Balancer Node.js + React MongoDB

## Resources Created
- **VPC**: 10.0.0.0/16 with public/private subnets
- **EC2 Instances**: 
  - Web Server (public): Node.js + React application
  - Database Server (private): MongoDB database
- **Security Groups**: Zero-trust security model
- **Networking**: Internet Gateway, Route Tables, Subnet associations

## Deployment Steps

### 1. Initialize Terraform
cd terraform
terraform init

2. Plan Infrastructure
terraform plan

3. Deploy Infrastructure
terraform apply

4. Access Application
After deployment, Terraform will output:

Web Server Public IP
Database Server Private IP
SSH connection command

5. Application URL
Access your MERN application at: http://WEB_SERVER_PUBLIC_IP

Security Features
SSH access restricted to your IP only
Database server completely isolated in private subnet
Web traffic allowed on ports 80/443 only
Least privilege security groups
Cost Estimation
t2.micro instances (Free Tier eligible)
Minimal data transfer costs
Estimated: < $10/month for demo usage
Cleanup
terraform destroy

#Files Structure
terraform/
├── main.tf              # Primary infrastructure
├── security-groups.tf   # Firewall rules
├── ec2-instances.tf     # Server configurations
├── outputs.tf           # Deployment outputs
└── README.md           # This file



