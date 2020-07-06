resource "aws_security_group_rule" "ingress_rule" {
  type                = "ingress"
  from_port           = var.ingress_from_port
  to_port             = var.ingress_to_port
  protocol            = var.ingress_protocol
  cidr_blocks         = var.ingress_cidr_blocks
  security_group_id   = var.sg_id
}

resource "aws_security_group_rule" "egress_rule" {
  count               = var.create_egress_rule ? 1 : 0
  type                = "egress"
  from_port           = var.egress_from_port
  to_port             = var.egress_to_port
  protocol            = var.egress_protocol
  cidr_blocks         = var.egress_cidr_blocks
  security_group_id   = var.sg_id
}

