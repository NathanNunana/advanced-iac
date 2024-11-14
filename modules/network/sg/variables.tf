variable "sg_name" {
  type        = string
  description = "value"
}

variable "sg_description" {
  type        = string
  description = "value"
  default     = "This is a security group module"
}

variable "vpc_id" {
  type        = string
  description = "value"
}

variable "sg_ingress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "value"
  default = [
    {
      description = ""
      from_port   = 433
      to_port     = 433
      protocol    = "tcp"
      cidr_blocks = []
    },
    {
      description = ""
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = []
    }
  ]
}

variable "sg_egress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "value"
  default = [
    {
      description = ""
      from_port   = 433
      to_port     = 433
      protocol    = "-1"
      cidr_blocks = []
    },
    {
      description = ""
      from_port   = 80
      to_port     = 80
      protocol    = "-1"
      cidr_blocks = []
    }
  ]
}
