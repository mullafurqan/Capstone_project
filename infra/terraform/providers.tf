terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }

  required_version = ">= 1.6.0"
}

provider "kubernetes" {
  # Uses your local kubeconfig (minikube context)
  config_path = "~/.kube/config"
}
