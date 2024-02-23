variable "vpc_id" {
  type        = string
  default     = ""
  description = "ID of VPC in which the web server will run"
}

variable "app_server_sg_id" {
  type        = string
  default     = ""
  description = "App Server Security Group ID"
}

variable "username" {
  type        = string
  default     = ""
  description = "Username for Database"
}

variable "password" {
  type        = string
  default     = ""
  description = "Password for Database"
  sensitive   = true
}
