resource "oci_core_security_list" "security-list" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	vcn_id = oci_core_vcn.vcn.id

	egress_security_rules {
		stateless = false
		destination = "0.0.0.0/0"
		destination_type = "CIDR_BLOCK"
		protocol = "6"
		tcp_options {
			min = 80
			max = 80
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
			min = 22
			max = 22
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
			min = 53
			max = 53
		}
	}
}
