output "minecraft_public_ip_address" {
  value = var.static_ip ? oci_core_public_ip.minecraft_public_ip[0].ip_address : oci_core_instance.minecraft_instance.public_ip
}

output "bluemap_public_ip_address" {
  value = var.bluemap ? oci_load_balancer_load_balancer.bluemap[0].ip_address_details[0].ip_address : null
}
