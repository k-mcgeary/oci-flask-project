data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_images" "latest_image" {
  compartment_id = var.compartment_ocid
  operating_system = "Oracle Linux"
  operating_system_version = "8"
  shape = "VM.Standard.A2.Flex"
}

resource "oci_core_vcn" "main_vcn" {
  compartment_id = var.compartment_ocid
  cidr_block     = "10.0.0.0/16"
  display_name   = "MainVCN"
}

resource "oci_core_internet_gateway" "main_internet_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id
  display_name   = "MainInternetGateway"
  enabled        = true
}

resource "oci_core_route_table" "main_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.main_vcn.id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.main_internet_gateway.id
  }
}

resource "oci_core_subnet" "main_subnet" {
  compartment_id       = var.compartment_ocid
  vcn_id               = oci_core_vcn.main_vcn.id
  cidr_block           = "10.0.1.0/24"
  display_name         = "MainSubnet"
  route_table_id       = oci_core_route_table.main_route_table.id
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_instance" "flask_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.A2.Flex"

  shape_config {
    ocpus = 1
    memory_in_gbs = 6
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.main_subnet.id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

source_details {
  source_type = "image"
  source_id   = data.oci_core_images.latest_image.images[0].id
}

  display_name = "FlaskAppInstance"
}
