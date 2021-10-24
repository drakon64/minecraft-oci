variable "oci_tenancy" {
	type = string
}

variable "oci_compartment" {
	type = string
}

variable "oci_compartment_name" {
	type = string
	default = "bedrockconnect"
}

variable "oci_compute_display_name" {
	type = string
	default = "bedrockconnect"
}

variable "oci_image_id" {
	type = string
	default = "ocid1.image.oc1.uk-london-1.aaaaaaaakacuzfpbs3vjqgdc2ujoiyfrh4m7m5byrlamc2ryju6n2y6eplea"
}

variable "ssh_authorized_keys" {
	type = string
}

variable "management_ip" {
	type = string
}

variable "topic_name" {
	type = string
	default = "minecraft"
}

variable "management_email" {
	type = string
}
