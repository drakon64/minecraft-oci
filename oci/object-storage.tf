resource "oci_objectstorage_bucket" "minecraft_backup" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  name           = var.backup_bucket_name
  namespace      = var.oci_namespace

  access_type  = "NoPublicAccess"
  auto_tiering = "InfrequentAccess"

  count = var.continuous_deployment ? 0 : 1
}

resource "oci_objectstorage_object_lifecycle_policy" "minecraft_backup" {
  bucket    = var.backup_bucket_name
  namespace = var.oci_namespace

  rules {
    action      = "ABORT"
    is_enabled  = "true"
    name        = "multipart-uploads"
    time_amount = 1
    time_unit   = "DAYS"

    target = "multipart-uploads"
  }
}
