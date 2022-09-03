# Earthfile Ref: https://docs.earthly.dev/docs/earthfile

VERSION 0.6

fmt:
    FROM docker.io/hashicorp/terraform:1.2.4
    COPY main.tf .
    RUN terraform fmt --recursive
    SAVE ARTIFACT main.tf AS LOCAL main.tf

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
