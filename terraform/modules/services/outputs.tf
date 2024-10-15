output "k-svc" {
  value = kubernetes_service_v1.terraform-devops-services.metadata[0].name
}