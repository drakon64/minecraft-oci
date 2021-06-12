resource "oci_core_dhcp_options" "dhcp-options" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	vcn_id = oci_core_vcn.vcn.id

	options {
		type = "DomainNameServer"
		server_type = "VcnLocalPlusInternet"
	}
}
