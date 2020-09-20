variable refresh_token {
  type = string
}
variable org_id {
  type = string
}

variable region {
  type = string
  default = "ap-southeast-2"
}

variable sddc_name {
  type = string
  default = "VMCandTFC"
}
/*
variable vpc_cidr {
  type = string
  default = "10.0.0.0/16"
}
*/
variable sddc_num_hosts {
  type = number
  default = 1
}

variable vxlan_subnet {
  type = string
  default = "172.16.1.0/23"
}