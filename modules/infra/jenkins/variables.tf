variable "ami" {
  type        = string
  description = "value"
}

variable "instance_type" {
  type        = string
  description = "value"
}

variable "public_subnet" {
  type        = string
  description = "value"
}

variable "az" {
  type        = list(string)
  description = "value"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_sg_id" {
  type        = list(string)
  description = "value"
}

variable "name" {
  type        = string
  description = ""
  default     = "jenkins"
}

variable "sg" {
  type        = list(string)
  description = "value"
}
