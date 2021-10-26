resource "oci_ons_notification_topic" "minecraft_monitoring" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	name = var.topic_name
}

resource "oci_ons_subscription" "monitoring_subscription" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	endpoint = var.management_email
	protocol = "EMAIL"
	topic_id = oci_ons_notification_topic.minecraft_monitoring.id
}
