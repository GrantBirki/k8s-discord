data "kubectl_file_documents" "kong_namespace_manifest" {
  content = file("modules/kong/kong-namespace.yaml")
}

resource "kubectl_manifest" "kong_namespace" {
  count     = length(data.kubectl_file_documents.kong_namespace_manifest.documents)
  yaml_body = element(data.kubectl_file_documents.kong_namespace_manifest.documents, count.index)
}
