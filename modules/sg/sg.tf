resource "aws_security_group" "main" {
  name                    = var.name
  description             = var.description
  vpc_id                  = var.vpc_id

  revoke_rules_on_delete  = var.revoke_rules_on_delete

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.name)
    },
  )
}

