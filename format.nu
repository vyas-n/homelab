#!/usr/bin/env nu

# TODO: wrap in nix
# TODO: fold into flake.nix

glob **/*.tf | path dirname | uniq | each {|dir| {
    terraform --chdir=$dir init --backend=false
    terraform-docs $dir
}}

prettier --write .
