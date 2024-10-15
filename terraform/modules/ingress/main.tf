provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "default"
}




resource "kubernetes_ingress_v1" "example_ingress" {
  metadata {
    name      = "terraform-ingress"
    namespace = "devops-namespace" # Assurez-vous que le namespace existe
  }

  spec {
    tls {
      hosts       = ["devops.simpleachat.com"]
      secret_name = "tls-secret"
    }

    rule {
      host = "devops.simpleachat.com"

      http {
        path {
          path      = "/"
          path_type = "Prefix" # Obligatoire dans `networking.k8s.io/v1`

          backend {
            service {
              name = var.devops-service-name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
