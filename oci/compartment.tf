resource "oci_identity_compartment" "tf-compartment" {
	compartment_id = var.oci_compartment
	description = "Minecraft"
	name = "minecraft"
}
