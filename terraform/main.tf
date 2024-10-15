provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "default"
}


resource "kubernetes_namespace" "devopsnampace" {
  metadata {
    name = "devops-namespace"
  }
}


module "deployments" {
  source = "./modules/deployments"
}

module "services" {
  source           = "./modules/services"
  devops_pod_label = module.deployments.select-label
}

module "ingress" {
  source              = "./modules/ingress"
  devops-service-name = module.services.k-svc
}


# # devops.simpleachat.com(domain name)



