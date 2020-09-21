variable refresh_token {
  type = string
}
variable org_id {
  type = string
}

variable region {
  type = string
  default = "eu-west-2"
}

variable sddc_name {
  type = string
  default = "VMCandTFC"
}

variable vmc_vpc_cidr {
  type = string
  default = "10.0.0.0/16"
}

variable sddc_num_hosts {
  type = number
  default = 1
}

variable vxlan_subnet {
  type = string
  default = "10.10.10.0/23"
}

variable sso_domain {
  type    = string
  default = "vmc.local"
}

variable host_instance_type {
  type = string
  default = "I3_METAL"
}