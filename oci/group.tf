resource "oci_identity_dynamic_group" "minecraft" {
	compartment_id = var.oci_tenancy
	description = "Minecraft"
	name = var.oci_compartment_name
	matching_rule = "ANY {instance.compartment.id = '${oci_identity_compartment.minecraft_compartment.id}'}"
}

resource "oci_identity_policy" "minecraft_backup" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	description = "Minecraft backup"
	name = var.backup_bucket_name
	statements = [
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to read buckets in compartment id ${oci_identity_compartment.minecraft_compartment.id} where target.bucket.name='${oci_objectstorage_bucket.minecraft_backup[0].name}'",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to manage objects in compartment id ${oci_identity_compartment.minecraft_compartment.id} where all {target.bucket.name='${oci_objectstorage_bucket.minecraft_backup[0].name}', any {request.permission='OBJECT_INSPECT', request.permission='OBJECT_READ', request.permission='OBJECT_CREATE', request.permission='OBJECT_OVERWRITE'}}"
	]

	count = var.continuous_deployment ? 0 : 1
}

resource "oci_identity_policy" "minecraft_monitoring" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	description = "Minecraft monitoring"
	name = "${var.oci_compute_display_name}-monitoring"
	statements = [
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to use metrics in compartment id ${oci_identity_compartment.minecraft_compartment.id} where target.metrics.namespace='minecraft'",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to inspect instances in compartment id ${oci_identity_compartment.minecraft_compartment.id}",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to inspect vnic-attachments in compartment id ${oci_identity_compartment.minecraft_compartment.id}",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to inspect vnics in compartment id ${oci_identity_compartment.minecraft_compartment.id}"
	]
}

resource "oci_identity_policy" "minecraft_continuous_deployment" {
	compartment_id = var.oci_tenancy
	description = "Minecraft continuous integration"
	name = "${var.backup_bucket_name}-continuous-integration"
	statements = [
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to read buckets in tenancy where target.bucket.name='${var.live_backup_bucket_name}'",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to manage objects in tenancy where all {target.bucket.name='${var.live_backup_bucket_name}', any {request.permission='OBJECT_INSPECT', request.permission='OBJECT_READ'}}"
	]

	count = var.continuous_deployment ? 1 : 0
}
