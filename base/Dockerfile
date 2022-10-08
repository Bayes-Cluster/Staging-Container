# NAME: Bayes-Cluster/base
FROM ubuntu:22.04

LABEL org.opencontainers.image.documentation="Oct 08, 2022"
LABEL org.opencontainers.image.authors="Bayes Cluster Maintenance Group"
LABEL org.opencontainers.artifact.description="Bayes Cluster Base Image - Statistics/Data Science/Machine Learning/Deep Learning"
LABEL org.opencontainers.image.source https://github.com/Bayes-Cluster/Staging-Container
LABEL org.opencontainers.image.documentation="https://github.com/Bayes-Cluster/Staging-Container"
LABEL org.opencontainers.image.version="0.0.1"

# Pre-requisites
SHELL ["/bin/bash", "-O", "extglob", "-c"]
RUN mkdir -p /work && chmod 777 /work
WORKDIR /work
ARG BASE_USER="bayes"
ARG UID="1000"
ARG GID="100"

USER root
# Environment Variables
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        sudo \
        software-properties-common \
        dirmngr \
        ed \
        gpg-agent \
        less \
        ca-certificates \
        lsb-release \
        apt-transport-https \
        file \
        zip \
        tzdata \
        locales \
        bash-completion \
        man-db \
        neovim \
        git \
        openssh-client \
        rsync \
        curl \
        wget && \
        apt-get clean all && rm -rf /var/lib/apt/lists/*

# Timezone & Locale
ARG TZ=Aisa/Shanghai
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8

# Install Python
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        python3-all-dev \
        python3-setuptools \
        build-essential \
        python3-wheel \
        python3-apt \
    && pip3 install -U pip \
    && pip3 install \
        pytype \
        pylint \
        yapf \
        pytest \
        wajig && \
        ln -svf /usr/bin/python3 /usr/bin/python && \
        ln -svf /usr/bin/pip3 /usr/bin/pip

# Install R
RUN wget -q -O - https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
                | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0"
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" 
# https://github.com/rocker-org/rocker/blob/master/r-ubuntu/jammy/Dockerfile
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    littler \
    r-base \
    r-base-dev \
    r-recommended \
    r-cran-docopt && \
    ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r && \
 	ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r && \
 	ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r && \
 	ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r && \
  	ln -s /usr/lib/R/site-library/littler/examples/update.r /usr/local/bin/update.r && \
 	rm -rf /tmp/downloaded_packages/ /tmp/*.rds && \
 	rm -rf /var/lib/apt/lists/*

# Add User
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${UID} \
    ${BASE_USER} && \
    usermod -aG sudo ${BASE_USER} && \
    echo "${BASE_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    cp /root/.bashrc /home/${BASE_USER}/.bashrc && \
    mkdir /home/${BASE_USER}/work && \
    chown -R ${BASE_USER}:${BASE_USER} /home/${BASE_USER}

WORKDIR /home/${BASE_USER}/work
USER ${BASE_USER}
ENV HOME /home/${BASE_USER}
ENV USER ${BASE_USER}
ENV PATH /home/${BASE_USER}/.local/bin:$PATH
RUN touch /home/${BASE_USER}/.sudo_as_admin_successful

CMD ["/bin/bash"]