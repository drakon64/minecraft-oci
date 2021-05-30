output "public-ip-for-compute-instance" {
	value = oci_core_instance.minecraft_instance.public_ip
}
