data "kubectl_file_documents" "frontend_deployment_manifest" {
  depends_on = [
    data.kubectl_file_documents.frontend_namespace_manifest
  ]
  content = file("modules/containers/frontend/deployment.yaml")
}

resource "kubectl_manifest" "frontend_deployment" {
  depends_on = [
    data.kubectl_file_documents.frontend_namespace_manifest
  ]
  count     = length(data.kubectl_file_documents.frontend_deployment_manifest.documents)
  yaml_body = element(data.kubectl_file_documents.frontend_deployment_manifest.documents, count.index)
}
