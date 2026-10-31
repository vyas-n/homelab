
resource "kubernetes_manifest" "homepage_kargo_project" {
  manifest = {
    apiVersion = "kargo.akuity.io/v1alpha1"
    kind       = "Project"
    metadata = {
      name = "homepage"
    }
  }
}
