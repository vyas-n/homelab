#! /usr/bin/env nu

for dir in (glob **/.terraform.lock.hcl | path dirname | uniq) {
    terraform -chdir=($dir) init --upgrade
}
