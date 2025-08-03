ARG BASE_IMAGE
ARG BASE_IMAGE_VERSION
ARG TARGETPLATFORM
FROM --platform=$TARGETPLATFORM $BASE_IMAGE:$BASE_IMAGE_VERSION

ENV NB_USER jovyan
ENV NB_UID 1000
ENV NB_GID 0
ENV NB_PREFIX /
ENV HOME /home/$NB_USER
ENV SHELL /bin/bash

ENV USERS_GID 100

ENV HOME_TMP /tmp_home/$NB_USER

ENV S6_CMD_WAIT_FOR_SERVICES_MAXTIME 300000

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS 2

ARG KUBECTL_VERSION=v1.31.6
ARG S6_VERSION=v3.2.0.2

SHELL ["/bin/bash", "-c"]

# install - usefull linux packages
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -yq update \
 && apt-get -yq install --no-install-recommends \
    apt-transport-https \
    bash \
    bzip2 \
    ca-certificates \
    curl \
    git \
    gnupg \
    gnupg2 \
    locales \
    lsb-release \
    nano \
    software-properties-common \
    tzdata \
    unzip \
    vim \
    wget \
    xz-utils \
    zip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ARG TARGETPLATFORM
RUN ARCH=$(echo "$TARGETPLATFORM" | cut -d '/' -f2) \
   && case "$ARCH" in \
      amd64) S6_ARCH="x86_64" ;; \
      arm64) S6_ARCH="aarch64" ;; \
      ppc64le) S6_ARCH="ppc64le" ;; \
      *) echo "Unsupported architecture: ${TARGETPLATFORM}"; exit 1 ;; \
    esac \
 && curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz" -o /tmp/s6-overlay-noarch.tar.xz \
 && curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-noarch.tar.xz.sha256" -o /tmp/s6-overlay-noarch.tar.xz.sha256 \
 && echo "$(cat /tmp/s6-overlay-noarch.tar.xz.sha256 | awk '{ print $1; }')  /tmp/s6-overlay-noarch.tar.xz" | sha256sum -c - \
 && curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.xz" -o /tmp/s6-overlay-${S6_ARCH}.tar.xz \
 && curl -fsSL "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.xz.sha256" -o /tmp/s6-overlay-${S6_ARCH}.tar.xz.sha256 \
 && echo "$(cat /tmp/s6-overlay-${S6_ARCH}.tar.xz.sha256 | awk '{ print $1; }')  /tmp/s6-overlay-${S6_ARCH}.tar.xz" | sha256sum -c - \
 && tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
 && tar -C / -Jxpf /tmp/s6-overlay-${S6_ARCH}.tar.xz \
 && rm /tmp/s6-overlay-noarch.tar.xz  \
       /tmp/s6-overlay-noarch.tar.xz.sha256 \
       /tmp/s6-overlay-${S6_ARCH}.tar.xz \
       /tmp/s6-overlay-${S6_ARCH}.tar.xz.sha256

RUN chmod 0775 /run

RUN curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${TARGETPLATFORM}/kubectl" -o /usr/local/bin/kubectl \
	&& curl -fsSL "https://dl.k8s.io/${KUBECTL_VERSION}/bin/${TARGETPLATFORM}/kubectl.sha256" -o /tmp/kubectl.sha256 \
 	&& echo "$(cat /tmp/kubectl.sha256 | awk '{ print $1; }')  /usr/local/bin/kubectl" | sha256sum -c - \
 	&& rm /tmp/kubectl.sha256 \
 	&& chmod +x /usr/local/bin/kubectl

RUN userdel -f $(getent passwd 1000 | cut -d: -f1) || true \
	&& useradd -M -N \
    --shell /bin/bash \
    --home ${HOME} \
    --uid ${NB_UID} \
    --gid ${NB_GID} \
    --groups ${USERS_GID} ${NB_USER} \
	&& usermod -a -G sudo ${NB_USER} \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -pv ${HOME} \
    && mkdir -pv ${HOME_TMP} \
    && chmod 2775 ${HOME} \
    && chmod 2775 ${HOME_TMP} \
    && chown -R ${NB_USER}:${USERS_GID} ${HOME} \
    && chown -R ${NB_USER}:${USERS_GID} ${HOME_TMP} \
    && chown -R ${NB_USER}:${NB_GID} /usr/local/bin

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

COPY --chown=${NB_USER}:${NB_GID} --chmod=755 s6/ /etc

USER $NB_UID

ENTRYPOINT ["/init"]