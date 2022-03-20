resource "oci_core_default_security_list" "default-security-list" {
  manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id

  ingress_security_rules {
    protocol    = 6
    source      = var.management_ip
    source_type = "CIDR_BLOCK"
    stateless   = false

    tcp_options {
      min = 22
      max = 22
    }
  }

  ingress_security_rules {
    protocol    = 6
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false

    tcp_options {
      min = var.java_port_min
      max = var.java_port_max
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.geyser ? [1] : []
    content {
      protocol    = 17
      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      stateless   = false

      udp_options {
        min = var.bedrock_port_min
        max = var.bedrock_port_max
      }
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.bluemap ? [1] : []
    content {
      protocol    = 6
      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      stateless   = false

      tcp_options {
        min = 80
        max = 80
      }
    }
  }

  dynamic "ingress_security_rules" {
    for_each = var.bluemap ? [1] : []
    content {
      protocol    = 6
      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      stateless   = false

      tcp_options {
        min = 443
        max = 443
      }
    }
  }

  egress_security_rules {
    protocol         = "all"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    stateless        = false
  }
}
