data "kubectl_file_documents" "prometheus_manifests" {
  content = file("modules/monitoring/prometheus.yaml")
}

resource "kubectl_manifest" "prometheus_manifest" {
  depends_on = [
    kubectl_manifest.monitoring_namespace
  ]
  count     = length(data.kubectl_file_documents.prometheus_manifests.documents)
  yaml_body = element(data.kubectl_file_documents.prometheus_manifests.documents, count.index)
}
