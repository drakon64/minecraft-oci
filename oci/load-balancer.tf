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

# resource "oci_load_balancer_ssl_cipher_suite" "bluemap" {
# 	name = "bluemap"
# 	ciphers = [ "ECDHE-ECDSA-AES128-GCM-SHA256", "ECDHE-RSA-AES128-GCM-SHA256", "ECDHE-ECDSA-AES256-GCM-SHA384", "ECDHE-RSA-AES256-GCM-SHA384", "ECDHE-ECDSA-CHACHA20-POLY1305", "ECDHE-RSA-CHACHA20-POLY1305", "DHE-RSA-AES128-GCM-SHA256", "DHE-RSA-AES256-GCM-SHA384" ]

	# count = var.bluemap_https ? 1 : 0
# }

data "oci_load_balancer_certificates" "bluemap" {
	load_balancer_id = oci_load_balancer_load_balancer.bluemap[0].id

	count = var.bluemap_https ? 1 : 0
}

resource "oci_load_balancer_listener" "bluemap" {
	default_backend_set_name = oci_load_balancer_backend_set.bluemap[0].name
	load_balancer_id = oci_load_balancer_load_balancer.bluemap[0].id
	name = "bluemap"
	port = var.bluemap_https ? 443 : 80
	protocol = var.bluemap_https ? "HTTP2" : "HTTP"

	dynamic "ssl_configuration" {
		for_each = var.bluemap_https ? [1] : []
		content {
			certificate_name = data.oci_load_balancer_certificates.bluemap[0].certificates[0].certificate_name
			# cipher_suite_name = "bluemap"
			cipher_suite_name = "oci-default-http2-ssl-cipher-suite-v1"
			protocols = [ "TLSv1.2" ]
			server_order_preference = "ENABLED"
			verify_peer_certificate = false
		}
	}

	count = var.bluemap ? 1 : 0
}

resource "oci_core_network_security_group" "bluemap" {
	compartment_id = oci_identity_compartment.minecraft_compartment.id
	vcn_id = oci_core_vcn.vcn.id

	display_name = "${var.oci_compute_display_name}_bluemap"

	count = var.bluemap ? 1 : 0
}

resource "oci_core_network_security_group_security_rule" "bluemap" {
	network_security_group_id = oci_core_network_security_group.bluemap[0].id
	direction = "INGRESS"
	protocol = 6
	source = "0.0.0.0/0"
	source_type = "CIDR_BLOCK"

	tcp_options {
		destination_port_range {
			min = var.bluemap_https ? 443 : 80
			max = var.bluemap_https ? 443 : 80
		}
	}

	count = var.bluemap ? 1 : 0
}

resource "oci_identity_policy" "bluemap_certbot" {
	compartment_id = var.oci_tenancy
	description = "BlueMap CertBot"
	name = "${var.oci_compute_display_name}-bluemap-certbot"
	statements = [
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to use dns-zones in tenancy where target.dns-zone.name='${var.bluemap_domain_zone}'",
		#"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to use dns-records in tenancy where all {target.dns-domain.name='_acme-challenge.${var.bluemap_domain_name}', target.dns-zone.name='${var.bluemap_domain_zone}', target.dns-record.type='TXT'}", # Despite what Oracle's documentation says, you cannot restrict access based on a specific domain name or record type
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to use dns-records in tenancy where target.dns-zone.name='${var.bluemap_domain_zone}'",
		"Allow dynamic-group ${oci_identity_dynamic_group.minecraft.name} to use load-balancers in compartment id ${oci_identity_compartment.minecraft_compartment.id}"
	]

	count = var.bluemap_https_policies ? 1 : 0
}
