# Terraform VPC Setup

A simple Terraform project to create an AWS VPC with public and private subnets, along with EC2 instances.

## What Does This Do?

This Terraform configuration creates:
- **VPC** - A custom Virtual Private Cloud
- **Public Subnet** - Internet-accessible subnet with a public EC2 instance
- **Private Subnet** - Internal-only subnet with a private EC2 instance
- **Internet Gateway** - Allows public subnet to access the internet
- **Route Tables** - Manages traffic routing
- **Security Groups** - Controls inbound/outbound traffic
- **EC2 Instances** - Two servers (one public, one private)

## Project Structure

```
terraform-vpc-setup/
├── root.tf              # Main configuration calling the module
├── root_vars.tf         # Variable declarations
├── terraform.tfvars     # Variable values (customize here)
└── modules/
    └── vpc_ec2/
        ├── main.tf      # VPC, subnets, and networking
        ├── ec2.tf       # EC2 instances
        ├── sg.tf        # Security groups
        ├── vars.tf      # Module variables
        └── outputs.tf   # Output values
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) installed
- AWS CLI configured with credentials
- An AWS key pair created (for SSH access)

## Configuration

Edit `terraform.tfvars` to customize:

```hcl
aws_region          = "ap-southeast-1"    # AWS region
vpc_cidr            = "10.0.0.0/16"       # VPC IP range
public_subnet_cidr  = "10.0.1.0/24"       # Public subnet range
private_subnet_cidr = "10.0.2.0/24"       # Private subnet range
instance_type       = "t2.micro"          # EC2 instance size
ami_id              = "ami-xxxxxx"        # Amazon Machine Image ID
key_name            = "your-key-pair"     # Your AWS key pair name
my_ip               = "x.x.x.x/32"        # Your IP for SSH access
```

**Important:** Replace `ami-xxxxxx` with a valid AMI ID for your region and update `my_ip` with your actual IP address.

## How to Use

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Preview Changes**
   ```bash
   terraform plan
   ```

3. **Deploy Infrastructure**
   ```bash
   terraform apply
   ```
   Type `yes` when prompted.

4. **View Outputs**
   After deployment, you'll see:
   - `public_ip` - Public IP of the public EC2 instance
   - `private_ip` - Private IP of the private EC2 instance

5. **Destroy Infrastructure** (when done)
   ```bash
   terraform destroy
   ```
   Type `yes` when prompted.

## Connect to Instances

**Public Instance:**
```bash
ssh -i /path/to/your-key.pem ec2-user@<public_ip>
```

**Private Instance:**
Connect through the public instance (bastion host):
```bash
ssh -i /path/to/your-key.pem -J ec2-user@<public_ip> ec2-user@<private_ip>
```

## Network Architecture

```
Internet
    |
Internet Gateway
    |
Public Subnet (10.0.1.0/24)
    |
Public EC2 Instance
    
VPC (10.0.0.0/16)
    |
Private Subnet (10.0.2.0/24)
    |
Private EC2 Instance
```

## Notes

- The public instance is accessible from the internet via your IP
- The private instance is only accessible from within the VPC
- Security groups control which ports are open
- All resources are tagged with "redhat-" prefix

## Cost Warning

Running this infrastructure will incur AWS charges. Remember to destroy resources when not in use with `terraform destroy`.
