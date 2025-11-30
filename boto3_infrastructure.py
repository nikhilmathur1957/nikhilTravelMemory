import boto3
import json

def create_vpc_infrastructure():
    ec2 = boto3.client('ec2', region_name='ca-central-1')
    
    try:
        # Create VPC
        vpc_response = ec2.create_vpc(CidrBlock='10.0.0.0/16')
        vpc_id = vpc_response['Vpc']['VpcId']
        print(f"Created VPC: {vpc_id}")
        
        # Add name tag to VPC
        ec2.create_tags(Resources=[vpc_id], Tags=[{'Key': 'Name', 'Value': 'kartiktravelmemory-vpc'}])
        
        # Enable DNS
        ec2.modify_vpc_attribute(VpcId=vpc_id, EnableDnsSupport={'Value': True})
        ec2.modify_vpc_attribute(VpcId=vpc_id, EnableDnsHostnames={'Value': True})
        
        print("VPC infrastructure setup completed")
        return vpc_id
        
    except Exception as e:
        print(f"Error creating infrastructure: {e}")
        return None

if __name__ == "__main__":
    create_vpc_infrastructure()
