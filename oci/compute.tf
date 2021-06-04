resource "oci_core_instance" "minecraft_instance" {
	availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
	compartment_id = oci_identity_compartment.tf-compartment.id
	shape = var.oci_compute_shape
	source_details {
		boot_volume_size_in_gbs = 50
		source_id = var.oci_image_id
		source_type = "image"
	}
	shape_config {
		memory_in_gbs = var.oci_compute_memory
		ocpus = var.oci_compute_ocpus
	}

	display_name = var.oci_compute_display_name
	create_vnic_details {
		assign_public_ip = true
		subnet_id = oci_core_subnet.vcn-subnet.id
	}
	instance_options {
		are_legacy_imds_endpoints_disabled = true
	}
	metadata = {
		ssh_authorized_keys = var.ssh_authorized_keys
	}
}
