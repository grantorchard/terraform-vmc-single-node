locals {
  aws_account_number = data.terraform_remote_state.aws-core.outputs.account_id
  public_subnets = data.terraform_remote_state.aws-core.outputs.public_subnets
  #vpc_cidr = data.terraform_remote_state.aws-core.outputs.vpc_cidr
}

provider "vmc" {
  refresh_token = var.refresh_token
  org_id = var.org_id
}


data vmc_connected_accounts "this" {
  account_number = local.aws_account_number
}

/*
data vmc_customer_subnets "this" {
  connected_account_id = data.vmc_connected_accounts.this.id
  region               = var.region
}
*/

resource "vmc_sddc" "this" {
  sddc_name           = var.sddc_name
  vpc_cidr            = "10.2.0.0/16"
  num_host            = var.sddc_num_hosts
  #sddc_type           = "1Node"
  #provider_type       = "AWS"
  region              = var.region
  vxlan_subnet        = "10.10.10.0/23"
  delay_account_link  = true
  skip_creating_vxlan = true
  sso_domain          = "vmc.local"
  host_instance_type  = "I3_METAL"

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

