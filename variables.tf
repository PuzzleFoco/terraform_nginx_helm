variable "controller_service" {
    description = "Settings for the ngnix controller"
    type        = any
    default     = {
        "enabled" : "true",
        "annotations": {},
        "loadBalancerIP" : ""
    }
}