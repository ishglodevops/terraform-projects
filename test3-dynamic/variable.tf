variable "ingressrules" {
  type = list(number)
  default = [80,443,8080,22]
}

variable "egressrules" {
  type = list(number)
  default = [80,443,25,3396,53,8080]
}


