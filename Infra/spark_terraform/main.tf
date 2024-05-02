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

output "ec2_public_ip" {
    value = module.ec2module.ec2_public_ip
}

output "ec2_public_dns" {
    value = module.ec2module.ec2_public_dns
}
