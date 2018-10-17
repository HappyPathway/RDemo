//--------------------------------------------------------------------
// Variables



//--------------------------------------------------------------------
// Modules
module "network" {
  source  = "app.terraform.io/AnsibleSSHDemos/network/aws"
  version = "3.0.8"

  availability_zones = ["us-east-1a"]
  key_name = "tfe-demos-darnold"
  network_name = "dev"
  region = "us-east-1"
}

module "public_service" {
  source  = "app.terraform.io/AnsibleSSHDemos/public-service/aws"
  version = "1.2.0"

  env = "darnold-test"
  instance_type = "t2.small"
  key_name = "tfe-demos-darnold"
  private_subnet_id = "${element(module.network.private_subnets, 0)}"
  public_subnet_id = "${element(module.network.public_subnets)}"
  service_healthcheck = "add/1/1"
  service_name = "simple-app"
  service_version = "5.0.0"
  vpc_id = "${module.network.vpc_id}"
}
