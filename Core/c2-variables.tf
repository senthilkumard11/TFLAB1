variable "vnet_name" {
  default = "Core-vNet"

}

variable "core_sbnt_name" {
  default = "core-sbnt"

}

variable "app_sbnt_name" {
  default = "app-sbnt"

}

variable "rg_tags" {
  type = map(string)
  default = {
    "Environment" = "Test"
    "Owner"       = "Senthil Kumar"
    "Core"        = "Infra Servies"
    "DR"          = "NaN"
  }

}