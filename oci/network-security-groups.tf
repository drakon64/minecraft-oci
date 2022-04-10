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

resource "oci_core_network_security_group_security_rule" "java" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "INGRESS"
  protocol                  = 6
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = var.java_port_min
      max = var.java_port_max
    }
  }
}

resource "oci_core_network_security_group_security_rule" "query" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "INGRESS"
  protocol                  = 17
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"

  udp_options {
    destination_port_range {
      min = var.query_port_min
      max = var.query_port_max
    }
  }

  count = var.query ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "bedrock" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "INGRESS"
  protocol                  = 17
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"

  udp_options {
    destination_port_range {
      min = var.bedrock_port_min
      max = var.bedrock_port_max
    }
  }

  count = var.geyser ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "http" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "INGRESS"
  protocol                  = 6
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }

  count = var.bluemap ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "https" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "INGRESS"
  protocol                  = 6
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }

  count = var.bluemap ? 1 : 0
}
