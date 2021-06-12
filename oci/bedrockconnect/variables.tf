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
	default = "ocid1.image.oc1.uk-london-1.aaaaaaaa242yn72gd7r2dgeogdgtibx7bknz6lf3ra27ci6xq3lom622dsqq"
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
