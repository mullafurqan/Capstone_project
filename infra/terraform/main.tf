# Create a Kubernetes namespace for the project
resource "kubernetes_namespace" "devopsx" {
  metadata {
    name = var.namespace

    labels = {
      project = "devopsx-2-0"
      environment = var.environment
    }
  }
}

# Example configmap managed by Terraform
resource "kubernetes_config_map" "devopsx_app_config" {
  metadata {
    name      = "devopsx-app-config"
    namespace = kubernetes_namespace.devopsx.metadata[0].name
    labels = {
      app = "devopsx"
    }
  }

  data = {
    APP_MESSAGE = "Hello from Terraform-managed ConfigMap!"
  }
}
