locals {
  load_average_warn = 100 / var.oci_compute_ocpus
  heap_warn         = (((var.oci_compute_memory - 2) - (1 / 3)) / (var.oci_compute_memory - 2)) * 100
  memory_critical   = ((var.oci_compute_memory - (1 / 6)) / var.oci_compute_memory) * 100
  heap_critical     = ((var.oci_compute_memory - (1 / 3)) / var.oci_compute_memory) * 100
}

resource "oci_monitoring_alarm" "High-CPU-Load-Average" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "High CPU Load Average on ${oci_core_instance.minecraft_instance.display_name}"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "LoadAverage[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.load_average_warn}"
  resolution                       = "1m"
  severity                         = "WARNING"
}

resource "oci_monitoring_alarm" "High-Heap-Utilization" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "High Heap Utilization on ${oci_core_instance.minecraft_instance.display_name}"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "HeapUtilization[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.heap_warn}"
  resolution                       = "1m"
  severity                         = "WARNING"
}

resource "oci_monitoring_alarm" "High-MSPT" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "High MSPT on ${oci_core_instance.minecraft_instance.display_name}"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "MillisecondsPerTick[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > 25"
  resolution                       = "1m"
  severity                         = "WARNING"
}

resource "oci_monitoring_alarm" "High-Disk-Utilization-root" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "High Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "RootDiskUtilization[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > 75"
  resolution                       = "1m"
  severity                         = "WARNING"
}

resource "oci_monitoring_alarm" "High-Disk-Utilization-boot-efi" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "High Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /boot/efi"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "EfiDiskUtilization[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > 75"
  resolution                       = "1m"
  severity                         = "WARNING"
}

resource "oci_monitoring_alarm" "Critical-CPU-Load-Average" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "Critical CPU Load Average on ${oci_core_instance.minecraft_instance.display_name}"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "LoadAverage[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() >= 100"
  repeat_notification_duration     = "PT1H"
  resolution                       = "1m"
  severity                         = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Memory-Utilization" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "Critical Memory Utilization on ${oci_core_instance.minecraft_instance.display_name}"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "MemoryUtilization[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.memory_critical}"
  repeat_notification_duration     = "PT1H"
  resolution                       = "1m"
  severity                         = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Heap-Utilization" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "Critical Heap Utilization on ${oci_core_instance.minecraft_instance.display_name}"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "HeapUtilization[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > ${local.heap_critical}"
  repeat_notification_duration     = "PT1H"
  resolution                       = "1m"
  severity                         = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-MSPT" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "Critical MSPT on ${oci_core_instance.minecraft_instance.display_name}"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "MillisecondsPerTick[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > 50"
  repeat_notification_duration     = "PT1H"
  resolution                       = "1m"
  severity                         = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Disk-Utilization-root" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "Critical Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "RootDiskUtilization[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > 90"
  repeat_notification_duration     = "PT1H"
  resolution                       = "1m"
  severity                         = "CRITICAL"
}

resource "oci_monitoring_alarm" "Critical-Disk-Utilization-boot-efi" {
  compartment_id = oci_identity_compartment.minecraft_compartment.id
  destinations = [
    oci_ons_notification_topic.minecraft_monitoring.id
  ]
  display_name                     = "Critical Disk Utilization on ${oci_core_instance.minecraft_instance.display_name} /boot/efi"
  is_enabled                       = "true"
  metric_compartment_id            = oci_identity_compartment.minecraft_compartment.id
  metric_compartment_id_in_subtree = "false"
  namespace                        = "minecraft"
  query                            = "EfiDiskUtilization[5m]{resourceId = ${oci_core_instance.minecraft_instance.id}}.mean() > 90"
  repeat_notification_duration     = "PT1H"
  resolution                       = "1m"
  severity                         = "CRITICAL"
}
