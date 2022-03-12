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

variable "continuous_deployment" {
  type    = bool
  default = false
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
  default = 6
}

variable "oci_compute_ocpus" {
  type    = number
  default = 3
}

variable "oci_volume_size" {
  type    = number
  default = 50
}

variable "minecraft_java_port" {
  type    = number
  default = 25565
}

variable "geyser" {
  type    = bool
  default = true
}

variable "bluemap" {
  type    = bool
  default = true
}

variable "bluemap_https" {
  type    = bool
  default = false
}

variable "bluemap_domain_zone" {
  type = string
}

variable "bluemap_domain_name" {
  type = string
}

variable "minecraft_bedrock_port" {
  type    = number
  default = 19132
}

variable "oci_compute_display_name" {
  type    = string
  default = "minecraft"
}

variable "oci_image_id" {
  type    = string
  default = "ocid1.image.oc1.uk-london-1.aaaaaaaadkpfeh6hnzt64adsw6xr4moayfjk33xi5d4l3ps4hdwwpcaqbjhq"
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

variable "topic_name" {
  type    = string
  default = "minecraft"
}

variable "enable_monitoring_emails" {
  type    = bool
  default = true
}

variable "management_email" {
  type    = string
  default = ""
}
