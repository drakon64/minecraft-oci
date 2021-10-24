resource "oci_core_subnet" "vcn-subnet" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	vcn_id = oci_core_vcn.vcn.id
	cidr_block = "10.0.0.0/24"
	security_list_ids = [oci_core_default_security_list.default-security-list.id]

	display_name = var.oci_compute_display_name
}
