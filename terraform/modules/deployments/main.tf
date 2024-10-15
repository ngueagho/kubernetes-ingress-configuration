provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "default"
}

resource "kubernetes_deployment_v1" "terraform-devops-deployment" {
  metadata {
    name      = "terraform-devops-deployment"
    namespace = "devops-namespace"
    labels = {
      app = "prod"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "prod"
      }
    }

    template {
      metadata {
        labels = {
          app = "prod"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "devops-container"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
