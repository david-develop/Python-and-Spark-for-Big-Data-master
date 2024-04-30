provider "aws" {
    region = "us-east-1"
}

/* module "vpcmodule" {
    source = "./vpc"
} */

module "sgmodule" {
    source = "./sg"
}

module "ec2module" {
    source = "./ec2"
    /* vpc_subnet_ec2_id = module.vpcmodule.vpc_subnet_id */
    sg_name = module.sgmodule.sg_name
}
