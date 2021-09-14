data "kubectl_file_documents" "backend_service_manifest" {
  depends_on = [
    data.kubectl_file_documents.backend_namespace_manifest
  ]
  content = file("modules/containers/backend/service.yaml")
}

resource "kubectl_manifest" "backend_service" {
  depends_on = [
    data.kubectl_file_documents.backend_namespace_manifest
  ]
  count     = length(data.kubectl_file_documents.backend_service_manifest.documents)
  yaml_body = element(data.kubectl_file_documents.backend_service_manifest.documents, count.index)
}
