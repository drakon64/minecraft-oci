locals {
	cpu_warn = 100 / var.oci_compute_ocpus
	cpu_critical = 100 - (100 / var.oci_compute_ocpus) == 0 ? 99 : 100 - (100 / var.oci_compute_ocpus)
	memory_critical = ((var.oci_compute_memory - 0.32) / var.oci_compute_memory) * 100
}

resource "oci_monitoring_alarm" "High-CPU-Utilization" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "High CPU Utilization on ${oci_core_instance.minecraft_instance.display_name}"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.minecraft_compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "oci_computeagent"
	pending_duration = "PT5M"
	query = "CpuUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.cpu_warn}"
	resolution = "1m"
	severity = "WARNING"
}

resource "oci_monitoring_alarm" "High-Disk-Utilization-root" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "High Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.minecraft_compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "minecraft"
	pending_duration = "PT5M"
	query = "DiskUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}, mount = \"/\"}.mean() > 75"
	resolution = "1m"
	severity = "WARNING"
}

resource "oci_monitoring_alarm" "High-Disk-Utilization-boot-efi" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "High Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /boot/efi"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.minecraft_compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "minecraft"
	pending_duration = "PT5M"
	query = "DiskUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}, mount = \"/boot/efi\"}.mean() > 75"
	resolution = "1m"
	severity = "WARNING"
}

resource "oci_monitoring_alarm" "Critical-CPU-Utilization" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "Critical CPU Utilization on ${oci_core_instance.minecraft_instance.display_name}"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.minecraft_compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "oci_computeagent"
	pending_duration = "PT5M"
	query = "CpuUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.cpu_critical}"
	repeat_notification_duration = "PT1H"
	resolution = "1m"
	severity = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Disk-Utilization-root" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "Critical Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.minecraft_compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "minecraft"
	pending_duration = "PT5M"
	query = "DiskUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}, mount = \"/\"}.mean() > 90"
	resolution = "1m"
	severity = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Disk-Utilization-boot-efi" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "Critical Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /boot/efi"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.minecraft_compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "minecraft"
	pending_duration = "PT5M"
	query = "DiskUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}, mount = \"/boot/efi\"}.mean() > 90"
	resolution = "1m"
	severity = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Memory-Utilization" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	destinations = [
		oci_ons_notification_topic.minecraft_monitoring.id
	]
	display_name = "Critical Memory Utilization on ${oci_core_instance.minecraft_instance.display_name}"
	is_enabled = "true"
	metric_compartment_id = oci_identity_compartment.minecraft_compartment.id
	metric_compartment_id_in_subtree = "false"
	namespace = "oci_computeagent"
	pending_duration = "PT5M"
	query = "MemoryUtilization[1m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.memory_critical}"
	repeat_notification_duration = "PT1H"
	resolution = "1m"
	severity = "CRITICAL"
}
