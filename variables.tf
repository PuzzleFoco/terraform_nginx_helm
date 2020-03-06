variable "controller_service" {
    description = "Settings for the ngnix controller"
    type        = any
    default     = {
        "enabled" : "true",
        "loadBalancerIP": "",
    }
}

variable "annotations" {
    description = "Annotations for the Controller Settings"
    type        = map
    default     = {}
}