#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell terraform openssh k0sctl

def main [] {
    # Clear logs from last execution
    rm ~/.cache/k0sctl/k0sctl.log

    # Deploy
    k0sctl apply --no-wait --config=k0sctl.yaml

    # Save kubeconfig
    mkdir ~/.kube/config.d
    touch ~/.kube/config.d/homezone-v1.yaml
    k0sctl kubeconfig --config=k0sctl.yaml | save -f ~/.kube/config.d/homezone-v1.yaml
}
