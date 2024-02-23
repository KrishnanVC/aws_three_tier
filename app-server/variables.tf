variable "myip" {
  type        = string
  default     = ""
  description = "My Ip adddress"
  validation {
    condition     = can(cidrhost(var.myip, 0))
    error_message = "Invalid IPv4 CIDR block format."
  }
}

variable "app_server_subnet_id_1" {
  type        = string
  default     = ""
  description = "ID of Subnet 1 in which the app server will run"
}

variable "app_server_subnet_id_2" {
  type        = string
  default     = ""
  description = "ID of Subnet 2 in which the app server will run"
}

variable "bastion_subnet_id" {
  type        = string
  default     = ""
  description = "ID of Subnet in which the bastion host will run"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "ID of VPC in which the app server will run"
}

variable "web_server_sg_id" {
  type        = string
  default     = ""
  description = "Web server security group ID"
}

variable "db_sg_id" {
  type        = string
  default     = ""
  description = "DB security group ID"
}
