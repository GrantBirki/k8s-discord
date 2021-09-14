data "kubectl_file_documents" "backend_namespace_manifest" {
  content = file("modules/containers/backend/namespace.yaml")
}

resource "kubectl_manifest" "backend_namespace" {
  count     = length(data.kubectl_file_documents.backend_namespace_manifest.documents)
  yaml_body = element(data.kubectl_file_documents.backend_namespace_manifest.documents, count.index)
}
