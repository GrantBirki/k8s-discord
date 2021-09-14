data "kubectl_file_documents" "kong_plugins_manifests" {
  content = file("modules/kong/kong-plugins.yaml")
}

resource "kubectl_manifest" "kong_plugins" {
  depends_on = [
    kubectl_manifest.kong
  ]
  count     = length(data.kubectl_file_documents.kong_plugins_manifests.documents)
  yaml_body = element(data.kubectl_file_documents.kong_plugins_manifests.documents, count.index)
}
