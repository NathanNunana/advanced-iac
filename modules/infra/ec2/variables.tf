variable "instance-type" {
  type        = string
  description = "value"
}

variable "subnet" {
  type        = string
  description = "value"
}

variable "vpc-sg-id" {
  type        = list(string)
  description = "value"
}

variable "tags" {
  type        = map(string)
  description = "value"
}
