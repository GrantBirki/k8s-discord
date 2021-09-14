data "kubectl_file_documents" "kong_routes_manifests" {
  content = file("modules/kong/kong-routes.yaml")
}

resource "kubectl_manifest" "kong_routes" {
  depends_on = [
    kubectl_manifest.kong
  ]
  count     = length(data.kubectl_file_documents.kong_routes_manifests.documents)
  yaml_body = element(data.kubectl_file_documents.kong_routes_manifests.documents, count.index)
}
