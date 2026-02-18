# https://just.systems

ci:
    just setup
    just format
    just validate
    just lint

setup:
    #!/usr/bin/env nu
    mise install
    tflint --init
    uv python install
    uv sync

    ./ansible/requirements.yml

    for tf_directory in (glob infra/**/*/.terraform.lock.hcl | path dirname | uniq) {
        terraform -chdir=($tf_directory) init --backend=false
    }

deploy:
    # k0s apply
    ./infra/k8s/homezone/k0sctl/deploy.nu

    # TODO: secrets tf workspace
    # cd secrets/terraform
    # ./deploy.nu
    # cd ../..

    # Ansible provisioning
    ./ansible/all.ansible-playbook.yaml

deploy-proxmox:
    terraform -chdir=infra/proxmox/terraform apply

lint:
    tflint --recursive --config=$(pwd)/.tflint.hcl

format:
    #!/usr/bin/env nu

    just --fmt --unstable

    terraform fmt --recursive .

    for tf_directory in (glob infra/**/*.tf | path dirname | uniq) {
        terraform-docs markdown $tf_directory
    }

    prettier --write .

    markdown-table-formatter **/*.md

deps-upgrade:
    #!/usr/bin/env nu

    mise upgrade

    for tf_directory in (glob infra/**/*/.terraform.lock.hcl | path dirname | uniq) {
        terraform -chdir=($tf_directory) init --upgrade
    }

    uv lock --upgrade

reboot-k8s-wkrs:
    #!/usr/bin/env nu

    for node in (kubectl get nodes -o wide | from ssv | get NAME) {
        # TODO: check if the node even needs to be rebooted at all
        kubectl cordon $node
        kubectl drain $node --delete-emptydir-data --ignore-daemonsets
        ssh $node -- sudo systemctl reboot
        sleep 10sec
        while (kubectl get nodes | from ssv | where {|| $in.NAME == $node } | first | get STATUS ) != "Ready,SchedulingDisabled" {
            sleep 2sec
        }
        kubectl uncordon $node
    }

server-upgrade:
    ansible-playbook ansible/upgrade.ansible-playbook.yaml

validate:
    #!/usr/bin/env nu

    for tf_directory in (glob infra/**/*/.terraform.lock.hcl | path dirname | uniq) {
        terraform -chdir=($tf_directory) validate
    }
