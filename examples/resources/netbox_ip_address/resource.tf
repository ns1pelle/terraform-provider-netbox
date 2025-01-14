resource "netbox_ip_address" "ip" {
  ip_address = "10.0.0.50/24"
  status     = "reserved"
  dns_name   = "dc-west-myvm-20.mydomain.local"
}
// Assumes Netbox already has a VM whos name matches 'dc-west-myvm-20'
data "netbox_virtual_machine" "myvm" {
  name_regex = "dc-west-myvm-20"
}

resource "netbox_interface" "myvm_eth0" {
  name               = "eth0"
  virtual_machine_id = data.netbox_virtual_machine.myvm.id
}

resource "netbox_ip_address" "myvm_ip" {
  ip_address   = "10.0.0.60/24"
  status       = "active"
  interface_id = netbox_interface.myvm_eth0.id
}
