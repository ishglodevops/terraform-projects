#Input Variables

## AWS Region
variable "aws_region" {
  description = "Region in which AWS resources are to be created"
  type = string
  default = "us-east-1"
}

##Environment Variable
variable "environment" {
  description = "Environment Varibale used as a prefix"
  type = string
  default = "dev"
}   

##Business Division
variable "business_division" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "SAP"
}   