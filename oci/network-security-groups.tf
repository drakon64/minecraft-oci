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
      min = var.minecraft_java_port
      max = var.minecraft_java_port
    }
  }
}

resource "oci_core_network_security_group_security_rule" "bedrock" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "INGRESS"
  protocol                  = 17
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"

  udp_options {
    destination_port_range {
      min = var.minecraft_bedrock_port
      max = var.minecraft_bedrock_port
    }
  }

  count = var.geyser ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "bluemap_http" {
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

resource "oci_core_network_security_group_security_rule" "bluemap_https" {
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

  count = var.bluemap_https ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "https" {
  network_security_group_id = oci_core_network_security_group.minecraft.id
  direction                 = "EGRESS"
  protocol                  = 6
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
}
