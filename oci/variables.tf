variable "oci_tenancy" {
	type = string
}

variable "oci_compartment" {
	type = string
}

variable "oci_namespace" {
	type = string
}

variable "oci_image_id" {
	type = string
	default = "ocid1.image.oc1.uk-london-1.aaaaaaaaxqnvra3zoe47okh5aqzyiwsd6iubnf4brijgcxwty75qxeqotvaa"
}

variable "ssh_authorized_keys" {
	type = string
}

variable "management_ip" {
	type = string
}
