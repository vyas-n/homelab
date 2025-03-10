#!/usr/bin/env nu

glob **/*.tf | path dirname | uniq | each {|dir| {
    terraform --chdir=$dir init --backend=false
    terraform-docs $dir
}}

prettier --write .
