# Earthfile Ref: https://docs.earthly.dev/docs/earthfile

VERSION 0.7

deploy-k0sctl:
    LOCALLY
    RUN k0sctl apply --config=k0sctl/digitalocean/k0sctl.yaml --kubeconfig-out=k0sctl/digitalocean/kubeconfig.yaml

rebuild-droplets:
    LOCALLY
    FOR droplet IN $(doctl compute droplet list | grep k8s- | awk '{ print $1 }')
        RUN doctl compute droplet-action rebuild $droplet --image ubuntu-20-04-x64
    END

refresh-kubeconfig:
    LOCALLY
    RUN kubectl config delete-context k0s-cluster || true
    RUN kubectl config delete-cluster k0s-cluster || true
    RUN kubectl config delete-user admin || true
    RUN KUBECONFIG=~/.kube/config:./k0sctl/digitalocean/kubeconfig.yaml kubectl config view --flatten > /tmp/config
    RUN mv /tmp/config ~/.kube/config
    RUN kubectx k0s-cluster

deploy:
    BUILD +deploy-k0sctl

docs:
    FROM ghcr.io/vyas-proj/dev:latest

    COPY . .
    FOR dir IN $(find "modules" -name "*.tf" | xargs dirname | uniq)
        RUN terraform-docs $dir
    END
    RUN npx prettier --write .

    FOR dir IN $(find "modules" -name "*.tf" | xargs dirname | uniq)
        SAVE ARTIFACT $dir/README.md AS LOCAL $dir/README.md
    END

fmt:
    FROM ghcr.io/vyas-proj/dev:latest

    USER dev

    COPY . .
    RUN terraform fmt --recursive .
    FOR file IN $(git diff --name-only | egrep '\.tf$')
        SAVE ARTIFACT $file AS LOCAL $file
    END
