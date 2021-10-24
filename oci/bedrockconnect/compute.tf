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
		assign_public_ip = false
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

	agent_config {
		plugins_config {
			desired_state = "ENABLED"
			name = "Block Volume Management"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Vulnerability Scanning"
		}
	}
}

data "oci_core_vnic_attachments" "bedrockconnect_vnic_attachments" {
	compartment_id = oci_identity_compartment.tf-compartment.id

	instance_id = oci_core_instance.bedrockconnect_instance.id
}

data "oci_core_private_ips" "bedrockconnect_private_ip" {
	vnic_id = data.oci_core_vnic_attachments.bedrockconnect_vnic_attachments.vnic_attachments["0"].vnic_id
}

resource "oci_core_public_ip" "bedrockconnect_public_ip" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	lifetime = "RESERVED"

	display_name = var.oci_compute_display_name
	private_ip_id = data.oci_core_private_ips.bedrockconnect_private_ip.private_ips["0"].id
}
