# https://just.systems

setup:
    mise install
    uv python install
    uv sync
    ansible-galaxy collection install -r ./ansible/requirements.yml --force
    fd --hidden .terraform.lock | xargs dirname | uniq | xargs -I {} terraform -chdir={} init --backend=false

deploy:
    # k0s apply
    # ./infra/k8s/homezone/k0sctl/deploy.nu

    # TODO: secrets tf workspace
    # cd secrets/terraform
    # ./deploy.nu
    # cd ../..

    # Ansible provisioning
    ansible-playbook ansible/all.ansible-playbook.yaml

format:
    just --fmt --unstable

    terraform fmt --recursive .

    fd .tf infra/ | xargs dirname | uniq | xargs -I {} terraform-docs markdown {}

    prettier --write .

    markdown-table-formatter **/*.md

deps-upgrade:
    fd --hidden .terraform.lock | xargs dirname | uniq | xargs -I {} terraform -chdir={} init --upgrade

    uv lock --upgrade
