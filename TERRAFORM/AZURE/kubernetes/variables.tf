variable "resource_group_location" {
    default = "<YOUR_RESOURCE_GROUP_LOCATION>"
}

variable "agent_count" {
    default = 3
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
    default = "k8sguru"
}

variable cluster_name {
      default = "k8sguru"
}

variable aks_service_principal_app_id {
    default = "<SERVICE_PRINCIPAL_APP_ID>"
}

variable aks_service_principal_client_secret {
    default = "<SERVICE_PRINCIPAL_CLIENT_SECRET>"
}