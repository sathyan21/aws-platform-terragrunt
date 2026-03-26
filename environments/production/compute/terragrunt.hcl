include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

terraform {
  source = "../../../modules/compute"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  environment       = local.env_vars.locals.environment
  region            = local.env_vars.locals.region
  vpc_id            = dependency.vpc.outputs.vpc_id
  subnet_id         = dependency.vpc.outputs.subnet_ids[0]
  instance_type     = "c5.xlarge"
}
