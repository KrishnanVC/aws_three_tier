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
