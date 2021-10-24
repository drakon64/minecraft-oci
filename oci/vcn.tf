resource "oci_core_vcn" "vcn" {
	cidr_blocks = [ "10.0.0.0/16" ]
	compartment_id = oci_identity_compartment.tf-compartment.id
	dns_label = "minecraft"

	display_name = var.oci_compute_display_name
}

resource "oci_core_internet_gateway" "internet_gateway" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	vcn_id = oci_core_vcn.vcn.id

	display_name = var.oci_compute_display_name
}

resource "oci_core_default_route_table" "route_table" {
	manage_default_resource_id = oci_core_vcn.vcn.default_route_table_id

	route_rules {
		destination = "0.0.0.0/0"
		destination_type = "CIDR_BLOCK"
		network_entity_id = oci_core_internet_gateway.internet_gateway.id
	}
}
