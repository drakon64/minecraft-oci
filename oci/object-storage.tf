resource "oci_objectstorage_bucket" "minecraft_backup" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	name = var.backup_bucket_name
	namespace = var.oci_namespace

	access_type = "NoPublicAccess"
	auto_tiering = "InfrequentAccess"
	versioning = "Enabled"
}

resource "oci_objectstorage_object_lifecycle_policy" "minecraft_backup" {
	bucket = var.backup_bucket_name
	namespace = var.oci_namespace

	rules {
		action = "DELETE"
		is_enabled = "true"
		name = "minecraft-backup"
		time_amount = var.backup_retention_days
		time_unit = "DAYS"

		target = "previous-object-versions"
	}
	rules {
		action = "ABORT"
		is_enabled = "true"
		name = "multipart-uploads"
		time_amount = 1
		time_unit = "DAYS"

		target = "multipart-uploads"
	}
}
