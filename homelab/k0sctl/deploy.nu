#!/usr/bin/env nu

def main [] {
    k0sctl apply --no-wait --config=k0sctl.yaml

    mkdir ~/.kube/config.d
    touch ~/.kube/config.d/homezone-v1.yaml
    k0sctl kubeconfig --config=k0sctl.yaml --user=homezone-admin --cluster=homezone-v1 | save -f ~/.kube/config.d/homezone-v1.yaml
}