data "kubectl_path_documents" "frontend_secret_manifest" {
  depends_on = [
    data.kubectl_file_documents.frontend_namespace_manifest
  ]
  sensitive_vars = {
    DISCORD_TOKEN = "${var.DISCORD_TOKEN}"
    TEST_GUILD_ID = "${var.TEST_GUILD_ID}"
    CLIENT_ID     = "${var.CLIENT_ID}"
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
