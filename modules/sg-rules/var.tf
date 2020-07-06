##############
# sg
##############
variable "sg_id" {
  description = "provide the security group id to which the rules to attach"
  type = string
}

##############
# Ingress rule
###############
variable ingress_from_port {
  description = "provide the start port of sg ingress rule"
  type = number
  default = 0
}

variable ingress_to_port {
  description = "provide the end port of sg ingress rule"
  type = number
  default = 65535
}

variable ingress_protocol {
  description = "provide ingress protocol"
  type = string
  default = "tcp"
}

variable ingress_cidr_blocks {
  description = "provide list of ingress cidr blocks"
  type = list
  default = ["0.0.0.0/0"]
}

##############
# egress rule
##############
variable create_egress_rule {
  description = "do you wish to create an egress rule"
  default = false
}

variable egress_from_port {
  description = "provide the start port of sg egress rule"
  type = number
  default = 0
}

variable egress_to_port {
  description = "provide the end port of sg egress rule"
  type = number
  default = 0
}

variable egress_protocol {
  description = "provide egress protocol"
  type = string
  default = "-1"
}

variable egress_cidr_blocks {
  description = "provide list of egress cidr blocks"
  type = list
  default = ["0.0.0.0/0"]
}

