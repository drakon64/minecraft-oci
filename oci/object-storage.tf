resource "oci_objectstorage_bucket" "minecraft_backup" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	name = var.backup_bucket_name
	namespace = var.oci_namespace

	auto_tiering = "InfrequentAccess"
	versioning = "Enabled"
}

resource "oci_objectstorage_object_lifecycle_policy" "minecraft_backup" {
	bucket = "minecraft-backup"
	namespace = var.oci_namespace

	rules {
		action = "DELETE"
		is_enabled = "true"
		name = "minecraft-backup"
		time_amount = "31"
		time_unit = "DAYS"

		target = "previous-object-versions"
	}
}
