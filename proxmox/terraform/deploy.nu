#!/usr/bin/env nu

# TODO: use this instead
#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell terraform openssh k0sctl

def main [] {
    terraform apply

    # Refresh SSH for these hosts
    let hosts: list<string> = terraform output --json hosts | from json

    for host in $hosts {
        # Remove the old key(s) from known_hosts
        ssh-keygen -R $host

        # Add the new key(s) to known_hosts (and also hash the hostname/address)
        ssh-keyscan -H $host | save --append ~/.ssh/known_hosts
    }
}
