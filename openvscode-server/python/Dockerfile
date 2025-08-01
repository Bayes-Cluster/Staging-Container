# openvscode-server/python/Dockerfile

ARG PIXI_VERSION=0.50.2
ARG TARGETPLATFORM


FROM --platform=$TARGETPLATFORM ubuntu:24.04 AS pixi_builder
ARG PIXI_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -Ls \
    "https://github.com/prefix-dev/pixi/releases/download/v${PIXI_VERSION}/pixi-$(uname -m)-unknown-linux-musl" \
    -o /pixi && chmod +x /pixi

RUN /pixi --version


FROM --platform=$TARGETPLATFORM openvscode-server-base:latest
LABEL maintainer="terenceliu98<terenceliu1012@gmail.com>"


USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY --from=pixi_builder --chown=root:root --chmod=0555 /pixi /usr/local/bin/pixi

USER jovyan
