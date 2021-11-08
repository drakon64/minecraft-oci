resource "oci_load_balancer_load_balancer" "bluemap" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	display_name = "bluemap"
	shape = "10Mbps-Micro"
	subnet_ids = [
		"${oci_core_subnet.vcn-subnet.id}"
	]

	network_security_group_ids = [
		"${oci_core_network_security_group.bluemap.id}"
	]
}

resource "oci_load_balancer_backend_set" "bluemap" {
	health_checker {
		protocol = "http"
	}

	load_balancer_id = oci_load_balancer_load_balancer.bluemap.id
	name = "bluemap"
	policy = "LEAST_CONNECTIONS"
}

resource "oci_load_balancer_backend" "bluemap" {
	backendset_name = oci_load_balancer_backend_set.bluemap.name
	ip_address = oci_core_instance.minecraft_instance.private_ip
	load_balancer_id = oci_load_balancer_load_balancer.bluemap.id
	port = 8100
}
