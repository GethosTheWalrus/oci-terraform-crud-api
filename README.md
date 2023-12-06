# Deploying Node.js apps on multiple clouds using Terraform

This repository contains code that will create a simple Node.js API that interacts with a database. Currently supported clouds are:
- OCI
- AWS

## Modules

### OCI
Creates the following resources:
- Compartment
- VCN
- Subnet
- Internet Gateway
- Route Table
- Security List

### AWS
Creates the following resources:
- DynamoDB Table
- Lambda Function

## Quick Start
***Note: You must have the following before continuing:***
- A working Terraform installation
- Proper certificates generated for your OCI user
- A working AWS CLI configuration
- A populated terraform.tfvars file
  
To spin up the infrastructure and application stack, execute the following commands within the "infrastructure" directory of the project:

### OCI
```
terraform init
terraform apply -auto-approve -target=module.oci
terraform apply -auto-approve -target=module.docker
```

### AWS
```
terraform init
terraform apply -auto-approve -target=module.aws
```
