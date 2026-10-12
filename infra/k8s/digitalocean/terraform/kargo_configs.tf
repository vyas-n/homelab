resource "kubernetes_namespace_v1" "homepage" {
	metadata {
	  name = "homepage"
		labels = {
		  "kargo.akuity.io/project" = "true"
		}
	}
}

resource "kubernetes_manifest" "homepage_kargo_project" {
	manifest = {
    apiVersion = "kargo.akuity.io/v1alpha1"
   	kind = "Project"
   	metadata = {
      name = kubernetes_namespace_v1.homepage.id
    }
	}
}
