resource "oci_identity_dynamic_group" "bedrockconnect" {
	compartment_id = var.oci_tenancy
	description = "BedrockConnect"
	name = var.oci_compartment_name
	matching_rule = "instance.id = '${oci_core_instance.bedrockconnect_instance.id}'"
}

resource "oci_identity_policy" "minecraft_monitoring" {
	compartment_id = oci_identity_compartment.tf-compartment.id
	description = "Minecraft monitoring"
	name = "minecraft-monitoring"
	statements = [
		"Allow dynamic-group ${oci_identity_dynamic_group.bedrockconnect.name} to use metrics in compartment id ${oci_identity_compartment.tf-compartment.id} where target.metrics.namespace='minecraft'"
	]
}
