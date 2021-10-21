locals {
	memory_warn = (oci_core_instance.minecraft_instance.shape_config[0].memory_in_gbs - 1) / oci_core_instance.minecraft_instance.shape_config[0].memory_in_gbs
	memory_critical = (oci_core_instance.minecraft_instance.shape_config[0].memory_in_gbs - 0.5) / oci_core_instance.minecraft_instance.shape_config[0].memory_in_gbs
}

resource "oci_monitoring_alarm" "High-CPU-Utilization" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "High CPU Utilization on ${oci_core_instance.minecraft_instance.display_name}"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.tf-compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "oci_computeagent"
	pending_duration = "PT5M"
	query = "CpuUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > 75"
	resolution = "1m"
	severity = "WARNING"
}

resource "oci_monitoring_alarm" "High-Disk-Utilization-root" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "High Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.tf-compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "minecraft"
	pending_duration = "PT5M"
	query = "DiskUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}, mount = \"/\"}.mean() > 75"
	resolution = "1m"
	severity = "WARNING"
}

resource "oci_monitoring_alarm" "High-Disk-Utilization-boot-efi" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "High Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /boot/efi"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.tf-compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "minecraft"
	pending_duration = "PT5M"
	query = "DiskUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}, mount = \"/boot/efi\"}.mean() > 75"
	resolution = "1m"
	severity = "WARNING"
}

resource "oci_monitoring_alarm" "High-Memory-Utilization" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "High Memory Utilization on ${oci_core_instance.minecraft_instance.display_name}"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.tf-compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "oci_computeagent"
	pending_duration = "PT5M"
	query = "MemoryUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.memory_warn}"
	resolution = "1m"
	severity = "WARNING"
}

resource "oci_monitoring_alarm" "Critical-CPU-Utilization" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "Critical CPU Utilization on ${oci_core_instance.minecraft_instance.display_name}"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.tf-compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "oci_computeagent"
	pending_duration = "PT5M"
	query = "CpuUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > 90"
	repeat_notification_duration = "PT1H"
	resolution = "1m"
	severity = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Disk-Utilization-root" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "Critical Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.tf-compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "minecraft"
	pending_duration = "PT5M"
	query = "DiskUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}, mount = \"/\"}.mean() > 90"
	resolution = "1m"
	severity = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Disk-Utilization-boot-efi" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "Critical Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /boot/efi"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.tf-compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "minecraft"
	pending_duration = "PT5M"
	query = "DiskUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}, mount = \"/boot/efi\"}.mean() > 90"
	resolution = "1m"
	severity = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Memory-Utilization" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "Critical Memory Utilization on ${oci_core_instance.minecraft_instance.display_name}"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.tf-compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "oci_computeagent"
	pending_duration = "PT5M"
	query = "MemoryUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.memory_critical}"
	repeat_notification_duration = "PT1H"
	resolution = "1m"
	severity = "CRITICAL"
}
