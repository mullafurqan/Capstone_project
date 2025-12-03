output "namespace_name" {
  description = "Name of the DevOpsX namespace created by Terraform"
  value       = kubernetes_namespace.devopsx.metadata[0].name
}

output "configmap_name" {
  description = "Name of the ConfigMap created by Terraform"
  value       = kubernetes_config_map.devopsx_app_config.metadata[0].name
}
