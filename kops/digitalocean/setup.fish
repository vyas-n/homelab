#!/usr/bin/env fish

# Refs:
# - https://kops.sigs.k8s.io/getting_started/digitalocean/#creating-a-single-master-cluster
# - https://medium.com/@jkinkead/brief-thoughts-on-kops-3a4411435323
kops create (ls *.kops.yaml | xargs -I {} echo "--filename={}")
kops create secret --name k8s.vyas-n.dev sshpublickey admin -i ~/.ssh/vyas-workbook-8.pub
kops update cluster --name k8s.vyas-n.dev --yes
kops export kubecfg --admin
kops validate cluster --name k8s.vyas-n.dev --wait 10m
