variable "myip" {
  type        = string
  default     = ""
  description = "My Ip adddress"
  validation {
    condition     = can(cidrhost(var.myip, 0))
    error_message = "Invalid IPv4 CIDR block format."
  }
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "ID of Subnet in which the web server will run"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "ID of VPC in which the web server will run"
}

variable "app_server_sg_id" {
  type        = string
  default     = ""
  description = "App server security group ID"
}
