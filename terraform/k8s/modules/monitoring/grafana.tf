data "kubectl_file_documents" "grafana_manifests" {
  content = file("modules/monitoring/grafana.yaml")
}

resource "kubectl_manifest" "grafana_manifest" {
  depends_on = [
    kubectl_manifest.monitoring_namespace,
    kubectl_manifest.prometheus_manifest
  ]
  count     = length(data.kubectl_file_documents.grafana_manifests.documents)
  yaml_body = element(data.kubectl_file_documents.grafana_manifests.documents, count.index)
}
