#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell terraform openssh k0sctl

def main [--init=false] {
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
    if $init {
        k0sctl apply --no-wait --config=k0sctl.yaml
    } else {
        k0sctl apply --config=k0sctl.yaml
    }

    # Save kubeconfig into local ~/kube/config.d/
    mkdir ~/.kube/config.d
    touch ~/.kube/config.d/homezone-v1.yaml
    let kubeconfig: record = k0sctl kubeconfig --config=k0sctl.yaml | from yaml
    let kubeconfig_filepath: path = "~/.kube/config.d/homezone-v1.yaml" | path expand
    $kubeconfig | to yaml | save -f $kubeconfig_filepath

    # Save Kubeconfig into 1Pass
    let host: string = $kubeconfig | get clusters.cluster.server | first
    let client_certificate: string = $kubeconfig | get users.user.client-certificate-data | first
    let client_key: string = $kubeconfig | get users.user.client-key-data | first
    let client_ca_certificate: string = $kubeconfig | get clusters.cluster.certificate-authority-data | first

    let secrets: list<string> = [
        # TODO: change kubeconfig upload to use process substitution
        # ref: https://github.com/nushell/nushell/issues/10610#issuecomment-2427673358
        $'kubeconfig\.yaml[file]=($kubeconfig_filepath)'
        $'host[password]=($host)',
        $'client_certificate[password]=($client_certificate)'
        $'client_key[password]=($client_key)'
        $'client_ca_certificate[password]=($client_ca_certificate)'
    ]
    op item edit 'HomeZone-v1' ...$secrets
}
