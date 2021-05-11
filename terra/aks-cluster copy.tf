provider "azurerm" {
   features {}
}

resource "azurerm_resource_group" "resource_gp" {
  name     = "oye"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "oye"
  location            = azurerm_resource_group.resource_gp.location
  resource_group_name = azurerm_resource_group.resource_gp.name
  dns_prefix          = "ade"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "main" {
  name                  = "oye"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 2

  tags = {
    Owner = "Oyedemilade Adesida"
  }
}


