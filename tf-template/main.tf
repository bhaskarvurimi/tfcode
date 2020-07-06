module "sg_module" {
  source = "../modules/sg"
  name = "test-sg"
  vpc_id = "vpc-0bf9d71501dc6b78c"
  revoke_rules_on_delete = false
  tags = {
    "team" = "tranformers",
    "created_for" = "accessing webapp"
  }
}

module "rules-1" {
  source = "../modules/sg-rules"
  sg_id = module.sg_module.security_group_id
  ingress_from_port = 22
  ingress_to_port = 22
  ingress_cidr_blocks = ["106.210.174.109/32"]
  create_egress_rule = true
}

module "rules-2" {
  source = "../modules/sg-rules"
  sg_id = module.sg_module.security_group_id
  ingress_from_port = 443
  ingress_to_port = 443
  ingress_cidr_blocks = ["106.210.174.109/32"]
  create_egress_rule = false
}

