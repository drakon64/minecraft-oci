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

variable "oci_compute_memory" {
  type    = number
  default = 8
}

variable "oci_compute_ocpus" {
  type    = number
  default = 3
}

variable "oci_volume_size" {
  type    = number
  default = 50
}

variable "oci_compute_display_name" {
  type    = string
  default = "minecraft"
}

variable "query" {
  type    = bool
  default = false
}

variable "geyser" {
  type    = bool
  default = true
}

variable "oci_image_id" {
  type    = string
  default = "ocid1.image.oc1.uk-london-1.aaaaaaaa4kzur5s3zhiyespdxox3rkqbvc7nei5dc6ctzg37umtalrgklexq"
}

variable "ssh_authorized_keys" {
  type = string
}

variable "static_ip" {
  type    = bool
  default = true
}

variable "management_ip" {
  type = string
}

variable "backup_bucket_name" {
  type    = string
  default = "minecraft-backup"
}
