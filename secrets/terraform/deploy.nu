#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell terraform

def main [] {
    terraform apply
}
