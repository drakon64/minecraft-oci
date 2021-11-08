output "minecraft_public_ip_address" {
	value = oci_core_public_ip.minecraft_public_ip.ip_address
}

output "bluemap_public_ip_address" {
	value = oci_load_balancer_load_balancer.bluemap.ip_address_details[0].ip_address
}
