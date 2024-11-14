variable "vpc_name" {
  type        = string
  description = "value"
  default     = "orto_vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "value"
  default     = "10.0.0.0/24"
}

variable "rt_cidr" {
  type        = string
  description = "value"
  default     = "0.0.0.0/0"
}

variable "rt_name" {
  type        = string
  description = "value"
  default     = "orto-rt"
}

variable "az" {
  type        = string
  description = "value"
  default     = "eu-west-1a"
}

variable "subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
  description = "value"
  default = {
    public = {
      cidr = "10.0.0.0/25"
      az   = "eu-west-1a"
    }
    private = {
      cidr = "10.0.0.128/25"
      az   = "eu-west-1b"
    }
  }
}

variable "igw" {
  type        = string
  description = "value"
  default     = "orto-igw"
}
