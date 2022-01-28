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

variable "oci_load_balancer_shape" {
  type    = string
  default = "10Mbps-Micro"
}

variable "minecraft_java_port" {
  type    = number
  default = 25565
}

variable "vanilla" {
  type    = bool
  default = false
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
  default = "ocid1.image.oc1.uk-london-1.aaaaaaaavv3qbd2o3gis63pwc46xuiiccfplwzgxjfiqnzb6t4b5ag4ydp6a"
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

variable "backup_retention_days" {
  type    = number
  default = 30
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
