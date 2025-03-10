#!/usr/bin/env nu

glob **/terraform.tf | path dirname | each {|dir|
    terraform-docs $dir
}

prettier --write .
