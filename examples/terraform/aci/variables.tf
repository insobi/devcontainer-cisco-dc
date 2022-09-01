variable "aci_url" {
  type    = string
  default = "https://198.18.133.200/"
}

variable "aci_user" {
  type    = string
  default = "admin"
}

variable "aci_pw" {
  type      = string
  default   = "C1sco12345"
  sensitive = true
}

variable "aci_insecure" {
  type    = bool
  default = true
}