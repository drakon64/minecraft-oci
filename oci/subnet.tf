resource "oci_core_subnet" "vcn-subnet" {
	# Required
	compartment_id = oci_identity_compartment.tf-compartment.id
	vcn_id = oci_core_vcn.vcn.id
	cidr_block = "10.0.0.0/24"
 
	# Optional
	security_list_ids = [oci_core_security_list.security-list.id]
	display_name = "minecraft"
}
