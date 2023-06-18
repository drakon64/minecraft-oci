data "oci_identity_availability_domains" "ads" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
}

resource "oci_core_instance" "minecraft_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.minecraft_compartment.id
  shape               = "VM.Standard.A1.Flex"

  agent_config {
    is_management_disabled = "true"
    is_monitoring_disabled = "false"

    plugins_config {
      name          = "Bastion"
      desired_state = "DISABLED"
    }

    plugins_config {
      name          = "Block Volume Management"
      desired_state = "DISABLED"
    }

    plugins_config {
      name          = "Management Agent"
      desired_state = "DISABLED"
    }

    plugins_config {
      name          = "Oracle Autonomous Linux"
      desired_state = "DISABLED"
    }

    plugins_config {
      name          = "Oracle Java Management Service"
      desired_state = "DISABLED"
    }

    plugins_config {
      name          = "Vulnerability Scanning"
      desired_state = "DISABLED"
    }
  }

  #  availability_config {
  #    is_live_migration_preferred = var.instance_availability_config_is_live_migration_preferred
  #    recovery_action             = var.instance_availability_config_recovery_action
  #  }

  create_vnic_details {
    assign_public_ip = var.static_ip ? false : true
    subnet_id        = oci_core_subnet.subnet.id
    nsg_ids          = [
      oci_core_network_security_group.minecraft.id
    ]
  }

  display_name = var.oci_compute_display_name

  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
  }

  shape_config {
    memory_in_gbs = var.oci_compute_memory
    ocpus         = var.oci_compute_ocpus
  }

  source_details {
    boot_volume_size_in_gbs = var.oci_volume_size
    source_id               = var.oci_image_id
    source_type             = "image"
  }
}

data "oci_core_vnic_attachments" "minecraft_vnic_attachments" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id

  instance_id = oci_core_instance.minecraft_instance.id

  count = var.static_ip ? 1 : 0
}

data "oci_core_private_ips" "minecraft_private_ip" {
  vnic_id = data.oci_core_vnic_attachments.minecraft_vnic_attachments[0].vnic_attachments[0].vnic_id

  count = var.static_ip ? 1 : 0
}

resource "oci_core_public_ip" "minecraft_public_ip" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  lifetime       = "RESERVED"

  display_name  = var.oci_compute_display_name
  private_ip_id = data.oci_core_private_ips.minecraft_private_ip[0].private_ips[0].id

  count = var.static_ip ? 1 : 0
}
