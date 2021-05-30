resource "oci_identity_dynamic_group" "minecraft_backup" {
	compartment_id = var.oci_tenancy
	description = "Minecraft backup"
	name = "minecraft-backup"

	matching_rule = "All {instance.id = '${oci_core_instance.minecraft_instance.id}'}"
}

resource "oci_identity_policy" "minecraft_backup" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	description = "Minecraft backup"
	name = "minecraft-backup"
	statements = [
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft_backup.name} to read buckets in compartment ${oci_identity_compartment.tf-compartment.name}",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft_backup.name} to manage objects in compartment ${oci_identity_compartment.tf-compartment.name} where any {request.permission='OBJECT_CREATE', request.permission='OBJECT_INSPECT'}"
	]
}
