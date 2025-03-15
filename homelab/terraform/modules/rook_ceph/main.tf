
resource "kubernetes_namespace" "rook_ceph" {
  metadata {
    name = "rook-ceph"
  }
}

resource "helm_release" "rook_ceph_cluster" { # https://artifacthub.io/packages/helm/rook/rook-ceph-cluster
  name       = "rook-ceph-cluster"
  chart      = "rook-ceph-cluster"
  repository = "https://charts.rook.io/release"
  version    = "1.16.4"

  namespace        = kubernetes_namespace.rook_ceph.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 300

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/rook-ceph-cluster/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]

  depends_on = [
    helm_release.rook_ceph_operator
  ]
}

resource "kubernetes_namespace" "rook_ceph_operator" {
  metadata {
    name = "rook-ceph-operator"
  }
}

resource "helm_release" "rook_ceph_operator" { # https://artifacthub.io/packages/helm/rook/rook-ceph
  name       = "rook-ceph-operator"
  chart      = "rook-ceph"
  repository = "https://charts.rook.io/release"
  version    = "1.16.4"

  namespace        = kubernetes_namespace.rook_ceph_operator.metadata[0].name
  create_namespace = false
  lint             = true
  timeout          = 300

  values = [
    yamlencode(yamldecode(file("${path.module}/helm/rook-ceph-operator/values.yaml"))), # remove yaml comments & formatting from diff calculations
    yamlencode({})
  ]
}
