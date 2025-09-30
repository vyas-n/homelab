#! /usr/bin/env nu

terraform fmt --recursive .

for dir in (glob **/.terraform.lock.hcl | path dirname | uniq) {
    terraform -chdir=($dir) init --backend=false
}

for dir in (glob **/*.tf | path dirname | uniq) {
    echo $"dir: ($dir)"
    terraform-docs markdown $dir
}

prettier --write .

markdown-table-formatter **/*.md
