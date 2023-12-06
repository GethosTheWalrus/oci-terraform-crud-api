# Start elastic container
resource "docker_container" "node" {
    image = "crud-api"
    name = "node"
    hostname = "node"
    env = ["ORACLEDB_CONNECTION_STRING=${var.db_connection_string}", "SITEURL=${var.compute_instance_ip}:80", "DEPLOYMENT=normal", "INFRA=oci"]
    restart= "no"
    must_run="true"
    ports {
        internal = 3000
        external = 80
        ip       = "0.0.0.0"
    }
}