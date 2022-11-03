# Earthfile Ref: https://docs.earthly.dev/docs/earthfile

VERSION 0.6

FROM ghcr.io/vyas-proj/dev:latest

deploy:
    BUILD +deploy-k8s-controllers

deploy-k8s-controllers:
    FROM +base
    RUN mkdir -p /home/dev/src
    WORKDIR /home/dev/src

    RUN brew install poetry
    COPY pyproject.toml poetry.lock .
    RUN poetry install

    COPY ansible/digitalocean/nyc3/requirements.yml .
    RUN poetry run ansible-galaxy collection install -r requirements.yml

    ARG SSH_AUTH_SOCK
    COPY ansible/digitalocean/nyc3/hosts.yaml ansible/digitalocean/nyc3/k8s-controllers.playbook.yaml .
    # TODO: Fix
    RUN --ssh --interactive poetry run ansible-playbook -i hosts.yaml k8s-controllers.playbook.yaml

docs:
    FROM +base

    COPY . .
    FOR dir IN $(find "modules" -name "*.tf" | xargs dirname | uniq)
        RUN terraform-docs $dir
    END
    RUN npx prettier --write .

    FOR dir IN $(find "modules" -name "*.tf" | xargs dirname | uniq)
        SAVE ARTIFACT $dir/README.md AS LOCAL $dir/README.md
    END

fmt:
    FROM +base

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
