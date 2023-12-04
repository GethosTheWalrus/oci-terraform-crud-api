# Configure the Docker provider
provider "docker" {
    host = "tcp://${var.compute_instance_ip}:1234/"
}