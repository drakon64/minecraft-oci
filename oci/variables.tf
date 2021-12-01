variable "oci_tenancy" {
	type = string
}

variable "oci_compartment" {
	type = string
}

variable "oci_compartment_name" {
	type = string
	default = "minecraft"
}

variable "oci_namespace" {
	type = string
}

variable "oci_compute_shape" {
	type = string
	default = "VM.Standard.A1.Flex"
}

variable "oci_compute_memory" {
	type = number
	default = 6
}

variable "oci_compute_ocpus" {
	type = number
	default = 3
}

variable "minecraft_java_port" {
	type = number
	default = 25565
}

variable "vanilla" {
	type = bool
	default = false
}

variable "minecraft_bedrock_port" {
	type = number
	default = 19132
}

variable "oci_compute_display_name" {
	type = string
	default = "minecraft"
}

variable "oci_image_id" {
	type = string
	default = "ocid1.image.oc1.uk-london-1.aaaaaaaa3n7iwq23xjrp7ecrexsjt4p3u2ahanf7in6dyy5day4ppa2mdv6q"
}

variable "ssh_authorized_keys" {
	type = string
}

variable "management_ip" {
	type = string
}

variable "backup_bucket_name" {
	type = string
	default = "minecraft-backup"
}

variable "backup_retention_days" {
	type = number
	default = 30
}

variable "topic_name" {
	type = string
	default = "minecraft"
}

variable "enable_monitoring_emails" {
	type = bool
	default = true
}

variable "management_email" {
	type = string
	default = ""
}
