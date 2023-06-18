variable "oci_tenancy" {
  type = string
}

variable "oci_compartment" {
  type = string
}

variable "oci_compartment_name" {
  type    = string
  default = "minecraft"
}

variable "oci_namespace" {
  type = string
}

variable "oci_compute_display_name" {
  type    = string
  default = "minecraft"
}

variable "oci_image_id" {
  type    = string
  default = "ocid1.image.oc1.uk-london-1.aaaaaaaa4kzur5s3zhiyespdxox3rkqbvc7nei5dc6ctzg37umtalrgklexq"
}

variable "ssh_authorized_keys" {
  type = string
}

variable "management_ip" {
  type = string
}

variable "backup_bucket_name" {
  type    = string
  default = "minecraft-backup"
}
