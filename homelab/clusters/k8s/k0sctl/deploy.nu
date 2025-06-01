#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell terraform openssh k0sctl

def main [] {
    # Refresh SSH for these hosts
    let ctr_hosts: list<record> = terraform -chdir=../../../terraform output --json k8s_ctr_nodes
        | from json
        | transpose hostname object
    let wkr_hosts: list<record> = terraform -chdir=../../../terraform output --json k8s_wkr_nodes
        | from json
        | transpose hostname object

    for host in ($ctr_hosts ++ $wkr_hosts) {
        print $host
        # Remove the old key(s) from known_hosts
        ssh-keygen -R $host.object.fqdn

        # Add the new key(s) to known_hosts (and also hash the hostname/address)
        ssh-keyscan -H $host.object.fqdn
            | save --append ~/.ssh/known_hosts
    }

    rm ~/.ssh/known_hosts.old

    # Clear logs from last execution
    rm -f ~/.cache/k0sctl/k0sctl.log

    # Deploy
    k0sctl apply --no-wait --config=k0sctl.yaml

    # Save kubeconfig
    mkdir ~/.kube/config.d
    touch ~/.kube/config.d/homezone-v1.yaml
    k0sctl kubeconfig --config=k0sctl.yaml | save -f ~/.kube/config.d/homezone-v1.yaml
}
