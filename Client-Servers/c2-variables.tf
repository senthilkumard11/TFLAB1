variable "appsrname" {
  default = ["server1", "server2"]

}


/*variable "dbsrname" {
  default = ["dbserver1", "dbserver2"]

}*/

variable "business_unit" {
  description = "Business Unit Name"
  type        = string
  default     = "HR"

}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "Dev"
}

variable "resoure_group_name" {
  description = "Resource Group Name"
  type        = string
  default     = "App-Server-RG"
}

variable "resource_group_location" {
  description = "Resource Group location"
  type        = string
  default     = "westeurope"

}