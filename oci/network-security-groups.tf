resource "oci_core_network_security_group" "minecraft" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  vcn_id         = oci_core_vcn.vcn.id

  display_name = var.oci_compute_display_name
}

resource "oci_core_network_security_group_security_rule" "ssh" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "INGRESS"
  protocol                  = 6
  source                    = var.management_ip
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_network_security_group_security_rule" "all" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "INGRESS"
  protocol                  = "all"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
}
