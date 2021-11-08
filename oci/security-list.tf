resource "oci_core_default_security_list" "default-security-list" {
	manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id

	ingress_security_rules {
		stateless = false
		source = var.management_ip
		source_type = "CIDR_BLOCK"
		protocol = "6"
		tcp_options {
			min = 22
			max = 22
		}
	}

	ingress_security_rules {
		stateless = false
		source = "0.0.0.0/0"
		source_type = "CIDR_BLOCK"
		protocol = "6"
		tcp_options {
			min = 25565
			max = 25565
		}
	}

	ingress_security_rules {
		stateless = false
		source = "0.0.0.0/0"
		source_type = "CIDR_BLOCK"
		protocol = "17"
		udp_options {
			min = 19132
			max = 19132
		}
	}

	egress_security_rules {
		stateless = false
		destination = "0.0.0.0/0"
		destination_type = "CIDR_BLOCK"
		protocol = "6"
		tcp_options {
			min = 443
			max = 443
		}
	}

ingress_security_rules {
		stateless = false
		source = var.management_ip
		source_type = "CIDR_BLOCK"
		protocol = "6"
		tcp_options {
			min = 8100
			max = 8100
		}
	}

	ingress_security_rules {
		stateless = false
		source = "10.0.0.0/8"
		source_type = "CIDR_BLOCK"
		protocol = "6"
		tcp_options {
			min = 8100
			max = 8100
		}
	}

	ingress_security_rules {
		stateless = false
		source = "0.0.0.0/0"
		source_type = "CIDR_BLOCK"
		protocol = "6"
		tcp_options {
			min = 80
			max = 80
		}
	}
}
