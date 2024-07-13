terraform {
    required_version = ">=1.0"
  
    required_providers {
      azapi = {
        source  = "azure/azapi"
        version = "~>1.5"
      }
      azurerm = {
        source  = "hashicorp/azurerm"
        version = "~>3.0"
      }
      random = {
        source  = "hashicorp/random"
        version = "~>3.0"
      }
      time = {
        source  = "hashicorp/time"
        version = "0.9.1"
      }
      kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.2"
      }
      helm = {
      source  = "hashicorp/helm"
      version = "2.5.0"
      }
      kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.0.1"
      }
    }
  }
  
  provider "azurerm" {
    features {}
  }
  
  provider "helm" {
    kubernetes {
      host = azurerm_kubernetes_cluster.k8s.kube_config.0.host

      client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
      client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
      cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
    }
  }

  provider "kubernetes" {
    host = azurerm_kubernetes_cluster.k8s.kube_config.0.host
  
    client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
  }