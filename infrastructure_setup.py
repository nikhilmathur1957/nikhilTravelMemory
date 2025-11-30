import boto3
import json

def create_infrastructure():
    ec2 = boto3.client('ec2', region_name='ca-central-1')
    
    # Create VPC
    vpc_response = ec2.create_vpc(CidrBlock='10.0.0.0/16')
    vpc_id = vpc_response['Vpc']['VpcId']
    print(f"Created VPC: {vpc_id}")
    
    # Enable DNS support
    ec2.modify_vpc_attribute(VpcId=vpc_id, EnableDnsSupport={'Value': True})
    ec2.modify_vpc_attribute(VpcId=vpc_id, EnableDnsHostnames={'Value': True})
    
    return vpc_id

if __name__ == "__main__":
    create_infrastructure()
