resource "oci_identity_policy" "minecraft_osms" {
	compartment_id = var.oci_tenancy
	description = "Minecraft OS Management Service"
	name = "${var.oci_compute_display_name}-osms"
	statements = [
		"Allow service osms to read instances in tenancy",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to read instance-family in compartment id ${oci_identity_compartment.minecraft_compartment.id}",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to use osms-managed-instances in compartment id ${oci_identity_compartment.minecraft_compartment.id}"
	]
}
