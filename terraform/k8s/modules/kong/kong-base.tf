data "kubectl_file_documents" "kong_manifests" {
  content = file("modules/kong/kong-base.yaml")
}

resource "kubectl_manifest" "kong" {
  depends_on = [
    kubectl_manifest.kong_namespace
  ]
  count     = length(data.kubectl_file_documents.kong_manifests.documents)
  yaml_body = element(data.kubectl_file_documents.kong_manifests.documents, count.index)
}
