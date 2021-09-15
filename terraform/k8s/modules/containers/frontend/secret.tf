data "kubectl_path_documents" "frontend_secret_manifest" {
  depends_on = [
    data.kubectl_file_documents.frontend_namespace_manifest
  ]
  sensitive_vars = {
    DISCORD_TOKEN = "${var.DISCORD_TOKEN}"
  }
  pattern = "modules/containers/frontend/secret.yaml"
}

resource "kubectl_manifest" "frontend_secret" {
  depends_on = [
    data.kubectl_file_documents.frontend_namespace_manifest
  ]
  count     = length(data.kubectl_path_documents.frontend_secret_manifest.documents)
  yaml_body = element(data.kubectl_path_documents.frontend_secret_manifest.documents, count.index)
}
