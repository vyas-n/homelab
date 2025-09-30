#! /usr/bin/env nu

terraform fmt --recursive .

glob **/.terraform.lock.hcl | path dirname | uniq | each {|dir| {
    terraform --chdir=$dir init --backend=false
}}

glob **/*.tf | path dirname | uniq | each {|dir| {
    terraform-docs $dir
}}

prettier --write .

markdown-table-formatter **/*.md
