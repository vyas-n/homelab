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

    glob infra/**/*/.terraform.lock.hcl | path dirname | uniq
        | par-each {|tf_directory|
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

server-upgrade:
    ansible-playbook ansible/upgrade.ansible-playbook.yaml

validate:
    #!/usr/bin/env nu

    for tf_directory in (glob infra/**/*/.terraform.lock.hcl | path dirname | uniq) {
        terraform -chdir=($tf_directory) validate
    }
