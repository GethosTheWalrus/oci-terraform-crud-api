cd ../infrastructure
terraform init
terraform apply -auto-approve -target=module.oci
terraform apply -auto-approve -target=module.docker