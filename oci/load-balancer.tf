resource "oci_load_balancer_load_balancer" "bluemap" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	display_name = "bluemap"
	shape = var.oci_load_balancer_shape
	subnet_ids = [
		"${oci_core_subnet.vcn-subnet.id}"
	]

	network_security_group_ids = [
		"${oci_core_network_security_group.bluemap[0].id}"
	]

	count = var.bluemap ? 1 : 0
}

resource "oci_load_balancer_backend_set" "bluemap" {
	health_checker {
		protocol = "HTTP"
		url_path = "/"
	}

	load_balancer_id = oci_load_balancer_load_balancer.bluemap[0].id
	name = "bluemap"
	policy = "LEAST_CONNECTIONS"

	count = var.bluemap ? 1 : 0
}

resource "oci_load_balancer_backend" "bluemap" {
	backendset_name = oci_load_balancer_backend_set.bluemap[0].name
	ip_address = oci_core_instance.minecraft_instance.private_ip
	load_balancer_id = oci_load_balancer_load_balancer.bluemap[0].id
	port = 8100

	count = var.bluemap ? 1 : 0
}

resource "oci_load_balancer_listener" "bluemap" {
	default_backend_set_name = oci_load_balancer_backend_set.bluemap[0].name
	load_balancer_id = oci_load_balancer_load_balancer.bluemap[0].id
	name = "bluemap"
	port = 80
	protocol = "HTTP"

	count = var.bluemap ? 1 : 0
}

resource "oci_core_network_security_group" "bluemap" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	vcn_id = oci_core_vcn.vcn.id

	display_name = var.oci_compute_display_name

	count = var.bluemap ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "bluemap" {
	network_security_group_id = oci_core_network_security_group.bluemap[0].id
	direction = "INGRESS"
	protocol = 6
	source = var.management_ip
	source_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = 80
			max = 80
		}
	}

	count = var.bluemap ? 1 : 0
}
