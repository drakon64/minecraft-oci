resource "oci_identity_compartment" "minecraft_compartment" {
	compartment_id = var.oci_compartment
	description = "Minecraft"
	name = var.oci_compartment_name
}
