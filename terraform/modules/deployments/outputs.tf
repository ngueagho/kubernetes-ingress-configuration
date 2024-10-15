
output "select-label" {
  value = kubernetes_deployment_v1.terraform-devops-deployment.spec[0].template[0].metadata[0].labels.app
}