resource "oci_core_default_security_list" "default-security-list" {
  manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id
}
