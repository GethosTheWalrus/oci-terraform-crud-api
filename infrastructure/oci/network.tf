############################################
# VCN
############################################
resource "oci_core_vcn" "the_vcn" {
  #Required
  compartment_id = oci_identity_compartment.the_compartment.id
  cidr_blocks    = var.demo_vcn.cidr_blocks
  #Optional
  display_name = var.demo_vcn.display_name
}

############################################
# Public Subnet
############################################
resource "oci_core_subnet" "the_subnet" {
  #Required
  compartment_id = oci_identity_compartment.the_compartment.id
  vcn_id         = oci_core_vcn.the_vcn.id
  cidr_block     = var.demo_subnet.cidr_block
  #Optional
  display_name               = var.demo_subnet.display_name
  prohibit_public_ip_on_vnic = !var.demo_subnet.is_public
  prohibit_internet_ingress  = !var.demo_subnet.is_public
}

############################################
# Internet Gateways and NAT Gateways
############################################
resource "oci_core_internet_gateway" "the_internet_gateway" {
  compartment_id = oci_identity_compartment.the_compartment.id
  vcn_id         = oci_core_vcn.the_vcn.id
  display_name   = var.internet_gateway.display_name
}


############################################
# Route Tables
############################################
resource "oci_core_default_route_table" "the_route_table" {
  #Required
  compartment_id             = oci_identity_compartment.the_compartment.id
  manage_default_resource_id = oci_core_vcn.the_vcn.default_route_table_id
  # Optional
  display_name = var.demo_subnet.route_table.display_name
  dynamic "route_rules" {
    for_each = [true]
    content {
      destination       = var.internet_gateway.ig_destination
      description       = var.demo_subnet.route_table.description
      network_entity_id = oci_core_internet_gateway.the_internet_gateway.id
    }
  }
}