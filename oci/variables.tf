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

variable "live_compartment_name" {
  type = string
}

variable "live_backup_bucket_name" {
  type = string
}

variable "oci_compute_shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "oci_compute_shape_flex" {
  type    = bool
  default = true
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

variable "java_port_min" {
  type    = number
  default = 25565
}

variable "java_port_max" {
  type    = number
  default = 25565
}

variable "query" {
  type    = bool
  default = false
}

variable "query_port_min" {
  type    = number
  default = 25565
}

variable "query_port_max" {
  type    = number
  default = 25565
}

variable "geyser" {
  type    = bool
  default = true
}

variable "bedrock_port_min" {
  type    = number
  default = 19132
}

variable "bedrock_port_max" {
  type    = number
  default = 19132
}

variable "bluemap" {
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
