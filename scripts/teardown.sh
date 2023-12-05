cd ../infrastructure
terraform destroy -auto-approve -target=module.docker
terraform destroy -auto-approve -target=module.oci