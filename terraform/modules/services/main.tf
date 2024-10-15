provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "default"
}

resource "kubernetes_service_v1" "terraform-devops-services" {
  metadata {
    name      = "terraform-devops-services"
    namespace = "devops-namespace"

  }
  spec {
    selector = {
      app = var.devops_pod_label
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }

    # type = "ClusterIp"
  }
}

