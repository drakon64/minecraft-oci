data "oci_identity_availability_domains" "ads" {
	compartment_id = oci_identity_compartment.tf-compartment.id
}

resource "oci_core_instance" "bedrockconnect_instance" {
	availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
	compartment_id = oci_identity_compartment.tf-compartment.id
	shape = "VM.Standard.E2.1.Micro"
	source_details {
		boot_volume_size_in_gbs = 50
		source_id = var.oci_image_id
		source_type = "image"
	}

	display_name = var.oci_compute_display_name
	create_vnic_details {
		assign_public_ip = true
		subnet_id = oci_core_subnet.vcn-subnet.id
		nsg_ids = [
			oci_core_network_security_group.bedrockconnect.id
		]
	}
	instance_options {
		are_legacy_imds_endpoints_disabled = true
	}
	metadata = {
		ssh_authorized_keys = var.ssh_authorized_keys
	}
}
