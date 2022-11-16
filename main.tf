
resource "random_id" "random_id_prefix" {
  byte_length = 2
}

locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}



module "networking" {
  source               = "./modules/vpc"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.production_availability_zones

}

module "web_server_sg" {

  source              = "./modules/securitygroup"
  vpc_id              = module.networking.vpc_id

  
}

module "webserver" {
  source         = "./modules/compute"
  depends_on = [
    module.web_server_sg
  ]
  count          = length(module.networking.public_subnets_id)
  vpc_id         = module.networking.vpc_id
  public_subnet  = element(module.networking.public_subnets_id,count.index)
  security_group = module.web_server_sg.web_server_security_group
  tags           = {

        name     = "webserver-${count.index}"
  }

}