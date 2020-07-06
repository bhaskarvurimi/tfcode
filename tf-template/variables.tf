################
# security group
################
variable "name" {
  description = "name of the security group"
  type = string
  default = "jenkins-test-sg"
}

variable "description" {
  description = "description of security group"
  type = string
  default = "security group created by jenkins job"
}

variable "vpc_id" {
  description = "this security group belong to which vpc, provide that vpc id"
  type = string
  default = "default"
}

variable "revoke_rules_on_delete" {
  description = "revoke all security group attached ingress and egress rules before delete"
  type = bool
  default = false
}

variable "tags" {
  description = "provide tags in key value format"
  type        = map(string)
  default = {
    "team" = "myteam",
    "created_for" = "to access xxx app"
  }
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
  default = 65537
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

