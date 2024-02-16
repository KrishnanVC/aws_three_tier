variable "myip" {
  type        = string
  default     = ""
  description = "My Ip adddress"
  validation {
    condition     = can(cidrhost(var.myip, 0))
    error_message = "Invalid IPv4 CIDR block format."
  }
}

variable "subnet_id_1" {
  type        = string
  default     = ""
  description = "ID of Subnet 1 in which the web server will run"
}

variable "subnet_id_2" {
  type        = string
  default     = ""
  description = "ID of Subnet 2 in which the web server will run"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "ID of VPC in which the web server will run"
}

variable "app_lb_sg_id" {
  type        = string
  default     = ""
  description = "App Load Balancer security group ID"
}

variable "app_lb_dns_name" {
  type        = string
  default     = ""
  description = "App load balancer dns name"
}
