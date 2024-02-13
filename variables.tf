variable "myip" {
  type        = string
  default     = ""
  description = "My Ip adddress"
  validation {
    condition     = can(cidrhost(var.myip, 0))
    error_message = "Invalid IPv4 CIDR block format."
  }
  sensitive = true
}
