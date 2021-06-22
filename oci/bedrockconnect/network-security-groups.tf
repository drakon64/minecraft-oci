resource "oci_core_network_security_group" "bedrockconnect" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	vcn_id = oci_core_vcn.vcn.id

	display_name = var.oci_compute_display_name
}

resource "oci_core_network_security_group_security_rule" "ssh" {
	network_security_group_id = oci_core_network_security_group.bedrockconnect.id
	direction = "INGRESS"
	protocol = 6
	source = var.management_ip
	source_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 22
			max = 22
		}
	}
}

resource "oci_core_network_security_group_security_rule" "dns" {
	network_security_group_id = oci_core_network_security_group.bedrockconnect.id
	direction = "INGRESS"
	protocol = 17
	source = "0.0.0.0/0"
	source_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 53
			max = 53
		}
	}
}

resource "oci_core_network_security_group_security_rule" "bedrockconnect" {
	network_security_group_id = oci_core_network_security_group.bedrockconnect.id
	direction = "INGRESS"
	protocol = 17
	source = "0.0.0.0/0"
	source_type = "CIDR_BLOCK"

	udp_options {
		destination_port_range {
			min = 19132
			max = 19132
		}
	}
}

resource "oci_core_network_security_group_security_rule" "http" {
	network_security_group_id = oci_core_network_security_group.bedrockconnect.id
	direction = "EGRESS"
	protocol = 6
	destination = "0.0.0.0/0"
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 80
			max = 80
		}
	}
}

resource "oci_core_network_security_group_security_rule" "https" {
	network_security_group_id = oci_core_network_security_group.bedrockconnect.id
	direction = "EGRESS"
	protocol = 6
	destination = "0.0.0.0/0"
	destination_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 443
			max = 443
		}
	}
}
