VERSION 0.6

fmt:
    FROM hashicorp/terraform:1.2.4
    COPY main.tf .
    RUN terraform fmt --recursive
    SAVE ARTIFACT main.tf AS LOCAL main.tf

validate:
    BUILD +validate-gitpod

validate-gitpod:
    FROM eu.gcr.io/gitpod-core-dev/build/installer:release-2022.06.0.10
    COPY k8s/kots/gitpod/gitpod.config.yaml .
    RUN ["/app/installer", "validate", "config", "--config", "gitpod.config.yaml"]

render-gitpod:
    BUILD +validate-gitpod
    FROM eu.gcr.io/gitpod-core-dev/build/installer:release-2022.06.0.10
    COPY k8s/kots/gitpod/gitpod.config.yaml .
    RUN ["/app/installer", "render", "--config", "gitpod.config.yaml", "--namespace", "gitpod", ">", "gitpod.yaml" ]
    SAVE ARTIFACT gitpod.yaml AS LOCAL k8s/generated/gitpod.yaml

lint-clusterlint:
    FROM golang:1.18.3-alpine3.16
    RUN apk add gcc libc-dev
    RUN go install github.com/digitalocean/clusterlint/cmd/clusterlint@v0.2.14
    
    # TODO Fix
    LOCALLY
    RUN clusterlint run --ignore-checks unused-secret --ignore-checks unused-config-map
