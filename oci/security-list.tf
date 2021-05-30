resource "oci_core_security_list" "security-list" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	vcn_id = oci_core_vcn.vcn.id

	egress_security_rules {
		stateless = false
		destination = "0.0.0.0/0"
		destination_type = "CIDR_BLOCK"
		protocol = "all"
	}

	ingress_security_rules {
		stateless = false
		source = "86.129.183.228/32"
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
}
