#! /usr/bin/env NIXPKGS_ALLOW_UNFREE=1 nix-shell
#! nix-shell -i nu --packages nushell terraform nodePackages.prettier

# TODO: wrap in nix
# TODO: fold into flake.nix

terraform fmt --recursive .

glob **/.terraform.lock.hcl | path dirname | uniq | each {|dir| {
    terraform --chdir=$dir init --backend=false
}}

glob **/*.tf | path dirname | uniq | each {|dir| {
    terraform-docs $dir
}}

prettier --write .
