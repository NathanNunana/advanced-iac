variable "eks_cluster_name" {
  type        = string
  description = "value"
  default     = "orto-cluster"
}

variable "ami" {
  type        = string
  description = "value"
  default     = "ami-0d64bb532e0502c46"
}

variable "instance_type" {
  type        = string
  description = "value"
  default     = "t3.medium"
}

variable "vpc_sg_ingress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "value"
}

variable "jenkins_sg_ingress" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "value"
}
