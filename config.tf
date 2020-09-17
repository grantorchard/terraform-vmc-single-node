terraform {
  required_providers {
    vmc = {
      source = "terraform-providers/vmc"
    }
  }
}

data terraform_remote_state "aws-core" {
  backend = "remote"

  config = {
    organization = "grantorchard"
    workspaces = {
      name = "terraform-aws-core"
    }
  }
}