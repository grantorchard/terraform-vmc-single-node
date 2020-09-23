locals {
  aws_account_number = data.terraform_remote_state.aws-core.outputs.account_id
  public_subnets = data.terraform_remote_state.aws-core.outputs.public_subnets
}

provider "vmc" {
  refresh_token = var.refresh_token
  org_id = var.org_id
}

data vmc_connected_accounts "this" {
  account_number = local.aws_account_number
}

resource vmc_sddc "this" {
  sddc_name           = var.sddc_name
  vpc_cidr            = var.vmc_vpc_cidr
  num_host            = var.sddc_num_hosts
  provider_type       = "AWS"
  region              = var.region
  vxlan_subnet        = var.vxlan_subnet
  delay_account_link  = false
  skip_creating_vxlan = false
  sso_domain          = var.sso_domain
  host_instance_type  = var.host_instance_type

  deployment_type = "SingleAZ"
  account_link_sddc_config {
    customer_subnet_ids  = [local.public_subnets[0]]
    connected_account_id = data.vmc_connected_accounts.this.id
  }
  timeouts {
    create = "300m"
    update = "300m"
    delete = "180m"
  }
}



