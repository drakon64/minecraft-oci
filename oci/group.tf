resource "oci_identity_dynamic_group" "minecraft_backup" {
	compartment_id = var.oci_tenancy
	description = "Minecraft backup"
	name = "minecraft-backup"

	matching_rule = "instance.id = '${oci_core_instance.minecraft_instance.id}'"
}

resource "oci_identity_policy" "minecraft_backup" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	description = "Minecraft backup"
	name = "minecraft-backup"
	statements = [
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft_backup.name} to read buckets in compartment id ${oci_identity_compartment.tf-compartment.id} where target.bucket.name='${oci_objectstorage_bucket.minecraft_backup.name}'",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft_backup.name} to manage objects in compartment id ${oci_identity_compartment.tf-compartment.id} where all {target.bucket.name='${oci_objectstorage_bucket.minecraft_backup.name}', any {request.permission='OBJECT_INSPECT', request.permission='OBJECT_READ', request.permission='OBJECT_CREATE', request.permission='OBJECT_OVERWRITE'}}"
	]
}
