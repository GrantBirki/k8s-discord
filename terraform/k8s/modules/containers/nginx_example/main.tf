########## NGINX Container ##########

resource "kubectl_manifest" "nginx_example_namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: nginx-example
YAML
}

resource "kubernetes_deployment" "nginx_example" {
  metadata {
    namespace = "nginx-example"
    name      = "example"
    labels = {
      app = "example"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "example"
      }
    }
    template {
      metadata {
        labels = {
          app = "example"
        }
      }
      spec {
        container {
          image = "nginxdemos/hello:latest"
          name  = "example"

          port {
            container_port = 80
          }

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
        }
      }
    }
  }
}

########## NGINX Service ##########

resource "kubernetes_service" "nginx_service_example" {
  metadata {
    namespace = "nginx-example"
    name      = "example"
    labels = {
      app = "example"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.nginx_example.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
  }
}
