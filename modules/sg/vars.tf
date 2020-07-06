################
# security group
################
variable "name" {
  description = "name of the security group"
  type = string
  default = "sg"
}

variable "description" {
  description = "description of security group"
  type = string
  default = "security group created by jenkins job"
}

variable "vpc_id" {
  description = "this security group belong to which vpc, provide that vpc id"
  type = string
}

variable "revoke_rules_on_delete" {
  description = "revoke all security group attached ingress and egress rules before delete"
  type = bool
  default = false
}

variable "tags" {
  description = "provide tags in key value format"
  type        = map(string)
  default     = {}
}

