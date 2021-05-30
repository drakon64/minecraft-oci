resource "oci_core_instance" "minecraft_instance" {
	availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
	compartment_id = oci_identity_compartment.tf-compartment.id
	shape = "VM.Standard.A1.Flex"
	source_details {
		source_id = var.oci_image_id
		source_type = "image"
	}
	shape_config {
		memory_in_gbs = 4
		ocpus = 4
	}

	display_name = "minecraft"
	create_vnic_details {
		assign_public_ip = true
		subnet_id = oci_core_subnet.vcn-subnet.id
	}
	metadata = {
		ssh_authorized_keys = var.ssh_authorized_keys
	}
}
