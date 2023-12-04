# ############################################
# # Database Instance
# ############################################
resource "oci_database_autonomous_database" "demo_database" {
    #Required
    compartment_id = oci_identity_compartment.the_compartment.id
    db_name = var.demo_database.name
    display_name = var.demo_database.name
    db_workload = var.demo_database.db_workload
    admin_password = var.demo_database.admin_password
    db_version = var.demo_database.db_version
    is_free_tier = var.demo_database.is_free_tier
    cpu_core_count = var.demo_database.cpu_core_count
    data_storage_size_in_gb = var.demo_database.data_storage_size_in_gb
    whitelisted_ips = concat([var.my_public_ip], [for k in oci_core_instance.the_instance.*.public_ip : chomp(k)])
}