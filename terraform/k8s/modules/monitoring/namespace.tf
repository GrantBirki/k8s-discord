data "kubectl_file_documents" "monitoring_namespace_manifest" {
  content = file("modules/monitoring/namespace.yaml")
}

resource "kubectl_manifest" "monitoring_namespace" {
  count     = length(data.kubectl_file_documents.monitoring_namespace_manifest.documents)
  yaml_body = element(data.kubectl_file_documents.monitoring_namespace_manifest.documents, count.index)
}
