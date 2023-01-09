# Earthfile Ref: https://docs.earthly.dev/docs/earthfile

VERSION 0.6

all:
    RUN echo sup

deploy-k0sctl:
    LOCALLY
    RUN k0sctl apply --config=k0sctl/digitalocean/k0sctl.yaml --kubeconfig-out=k0sctl/digitalocean/kubeconfig.yaml

refresh-kubeconfig:
    LOCALLY
    RUN kubectl config delete-context k0s-cluster || true
    RUN kubectl config delete-cluster k0s-cluster || true
    RUN kubectl config delete-user admin || true
    RUN KUBECONFIG=~/.kube/config:./k0sctl/digitalocean/kubeconfig.yaml kubectl config view --flatten > /tmp/config
    RUN mv /tmp/config ~/.kube/config
    RUN kubectx k0s-cluster

deploy:
    BUILD +deploy-k8s-controllers

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

    COPY . .
    RUN terraform fmt --recursive .
    FOR file IN $(git diff --name-only | egrep '\.tf$')
        SAVE ARTIFACT $file AS LOCAL $file
    END

deps-tf:
    ARG --required TFE_TOKEN

    FROM docker.io/hashicorp/terraform:latest
    COPY --dir k8s main.tf .terraform.lock.hcl .
    RUN echo "
credentials \"app.terraform.io\" {
    token = \"$TFE_TOKEN\"
}" > /root/.terraformrc
    RUN terraform init -input=false
    RUN terraform output kubeconfig | tail -n +2 | head -n -1 > sample.yaml
    SAVE ARTIFACT sample.yaml sample.yaml

generate:
    LOCALLY

    RUN cue eval -f tf-infra/digitalocean/sfo3/k8s/templates/docker-creds.cue --outfile tf-infra/digitalocean/sfo3/k8s/generated/config.json

lint-megalinter:
    FROM docker.io/oxsecurity/megalinter:v6
    COPY . .
    RUN --no-cache ls -alh && echo $PATH

lint-clusterlint:
    FROM docker.io/library/golang:1.18.3-alpine3.16
    RUN apk add gcc libc-dev curl
    RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    RUN curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c
    RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    RUN go install github.com/digitalocean/clusterlint/cmd/clusterlint@v0.2.14

    COPY +deps-tf/sample.yaml /root/.kube/config

    RUN --no-cache clusterlint run --ignore-checks unused-secret --ignore-checks unused-config-map
