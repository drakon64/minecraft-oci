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
	default = "ocid1.image.oc1.uk-london-1.aaaaaaaabs5halw76hevhsst3l2vmbtgth3jr3pqw5llgp7pqwjbxomvtgva"
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
