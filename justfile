# https://just.systems

ci:
    just setup
    just format
    just validate
    just lint

setup:
    mise run setup

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
    mise run format

upgrade-deps:
    #!/usr/bin/env nu

    mise run upgrade-deps

reboot-k8s-wkrs:
    #!/usr/bin/env nu

    for node in (kubectl get nodes -o wide | from ssv | get NAME) {
        let restart_check = ssh k8s-wkr-0.vms.vyas-n.dev -- dnf needs-restarting -r | complete | tee { print }

        if restart_check.exit_code != 0 {
            kubectl cordon $node
            kubectl drain $node --delete-emptydir-data --ignore-daemonsets
            ssh $node -- sudo systemctl reboot
            sleep 10sec
            while (kubectl get nodes | from ssv --aligned-columns | where {|| $in.NAME == $node } | first | get STATUS ) != "Ready,SchedulingDisabled" {
                sleep 2sec
            }
            kubectl uncordon $node
        }
    }

server-upgrade:
    ansible-playbook ansible/upgrade.ansible-playbook.yaml

validate:
    #!/usr/bin/env nu

    for tf_directory in (glob infra/**/*/.terraform.lock.hcl | path dirname | uniq) {
        terraform -chdir=($tf_directory) validate
    }
