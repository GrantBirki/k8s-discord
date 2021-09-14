data "kubectl_file_documents" "frontend_namespace_manifest" {
  content = file("modules/containers/frontend/namespace.yaml")
}

resource "kubectl_manifest" "frontend_namespace" {
  count     = length(data.kubectl_file_documents.frontend_namespace_manifest.documents)
  yaml_body = element(data.kubectl_file_documents.frontend_namespace_manifest.documents, count.index)
}
