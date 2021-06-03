output "public-ip-for-minecraft-server" {
	value = oci_core_instance.minecraft_instance.public_ip
}
