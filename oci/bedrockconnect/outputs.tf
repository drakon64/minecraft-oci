output "public-ip-for-bedrockconnect-server" {
	value = oci_core_instance.bedrockconnect_instance.public_ip
}
