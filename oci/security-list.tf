resource "oci_core_default_security_list" "default-security-list" {
	manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id

	ingress_security_rules {
		protocol = "all"
		source = "0.0.0.0/0"
		source_type = "CIDR_BLOCK"
		stateless = false
	}

	egress_security_rules {
		protocol = "all"
		source = "0.0.0.0/0"
		source_type = "CIDR_BLOCK"
		stateless = false
	}
}
