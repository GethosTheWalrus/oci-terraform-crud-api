# ############################################
# # Compute Instance
# ############################################
resource "oci_core_instance" "the_instance" {
  #Required
  compartment_id      = oci_identity_compartment.the_compartment.id
  shape               = var.demo_pub_vm.shape.name
  availability_domain = var.availability_domain
  display_name        = var.demo_pub_vm.display_name

  source_details {
    source_id   = var.demo_pub_vm.image_ocid
    source_type = "image"
  }

  dynamic "shape_config" {
    for_each = [true]
    content {
      #Optional
      memory_in_gbs = var.demo_pub_vm.shape.memory_in_gbs
      ocpus         = var.demo_pub_vm.shape.ocpus
    }
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.the_subnet.id
    assign_public_ip = var.demo_pub_vm.assign_public_ip
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file(var.my_private_key_path)
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    script = "../scripts/setup.sh"
  }

  metadata = {
    ssh_authorized_keys = join("\n", [for k in var.my_ssh_public_keys : chomp(k)])
  }
}