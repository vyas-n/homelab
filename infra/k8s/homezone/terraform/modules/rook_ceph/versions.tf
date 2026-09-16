/*
 * # Rook Ceph CSI Deployment & Config
 *
 * This module has a few manual steps involved. In particular you need to:
 * 1. Run this export step on the proxmox cluster running Ceph: https://www.rook.io/docs/rook/v1.19/CRDs/Cluster/external-cluster/provider-export/?h=export
 * 2. terraform apply this module
 * 3. Run this import step on the kubernetes cluster using the exported variables: https://www.rook.io/docs/rook/v1.19/CRDs/Cluster/external-cluster/consumer-import/
 *
 *
 */
terraform {
  required_version = ">= 1.14.2"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0"
    }
  }
}
