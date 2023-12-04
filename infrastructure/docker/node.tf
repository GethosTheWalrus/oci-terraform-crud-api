# Start elastic container
resource "docker_container" "node" {
    image = "${docker_image.node}"
    name = "node"
    hostname = "node"
    env = ["ORACLEDB_CONNECTION_STRING=${var.db_connection_string}", "SITEURL=${var.compute_instance_ip}:3000"]
    restart= "no"
    must_run="true"
}

# Pull images
resource "docker_image" "node" {
    name = "node:20.8.1-alpine"
}