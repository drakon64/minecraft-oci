resource "oci_identity_compartment" "tf-compartment" {
	compartment_id = var.oci_compartment
	description = "BedrockConnect"
	name = var.oci_compartment_name
}
