#!/usr/bin/env nu

#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell terraform openssh

def main [] {
    let k8s_hosts: list<string> = terraform state list
        | lines
        | filter {
            str contains .proxmox_virtual_environment_vm.vm
        }
        | filter {
            str contains .k8s_
        }

    for host in $k8s_hosts {
        print $host
        terraform taint $host
    }
}
