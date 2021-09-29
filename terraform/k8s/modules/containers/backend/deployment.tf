data "kubectl_path_documents" "backend_deployment_manifest" {
  depends_on = [
    data.kubectl_file_documents.backend_namespace_manifest
  ]

  vars = {
    ENVIRONMENT = "${var.ENVIRONMENT}"
    IMAGE_TAG   = "${var.IMAGE_TAG}"
    ACR_NAME    = "${var.ACR_NAME}"
  }
  pattern = "modules/containers/backend/deployment.yaml"
}

resource "kubectl_manifest" "backend_deployment" {
  depends_on = [
    data.kubectl_file_documents.backend_namespace_manifest
  ]
  count     = length(data.kubectl_path_documents.backend_deployment_manifest.documents)
  yaml_body = element(data.kubectl_path_documents.backend_deployment_manifest.documents, count.index)
}
