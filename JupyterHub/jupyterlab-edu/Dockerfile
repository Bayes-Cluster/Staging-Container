# NAME baeys-cluster/jupyterlab
FROM registry.cn-hangzhou.aliyuncs.com/bayes-cluster/jupyterlab-cpu:0.1.2

LABEL org.opencontainers.image.documentation="Oct 08, 2022"
LABEL org.opencontainers.image.authors="Bayes Cluster Maintenance Group"
LABEL org.opencontainers.artifact.description="Bayes Cluster Jupyterlab Image - Statistics/Data Science/Machine Learning/Deep Learning"
LABEL org.opencontainers.image.source https://github.com/Bayes-Cluster/Staging-Container
LABEL org.opencontainers.image.documentation="https://github.com/Bayes-Cluster/Staging-Container"
LABEL org.opencontainers.image.title="jupyterhub"
LABEL org.opencontainers.image.version="3.0.0"

# Pre-requisites
SHELL ["/bin/bash", "-O", "extglob", "-c"]
ARG BASE_USER="bayes"
ARG UID="1000"
ARG GID="100"
USER root

# Install NodeJS & NPM
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nodejs \
        npm && \
        apt-get clean all && rm -rf /var/lib/apt/lists/* 

RUN python3 -m pip install --pre jupyterlab 

RUN python3 -m pip install jupyterlab-link-share \
            jupyterlab-webrtc-docprovider \
            numpy \ 
            scipy \
            sympy \
            plotly \
            ipywidgets \
            matplotlib

USER root
RUN bash -c "echo SHELL=/bin/bash >> /etc/environment"
EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "lab", "--collaborative"]

USER root

# HEALTHCHECK documentation: https://docs.docker.com/engine/reference/builder/#healthcheck
# This healtcheck works well for `lab`, `notebook`, `nbclassic`, `server` and `retro` jupyter commands
# https://github.com/jupyter/docker-stacks/issues/915#issuecomment-1068528799
HEALTHCHECK  --interval=15s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -O- --no-verbose --tries=1 --no-check-certificate \
    http${GEN_CERT:+s}://localhost:8888${JUPYTERHUB_SERVICE_PREFIX:-/}api || exit 1

# Switch back to bayes to avoid accidental container runs as root
USER bayes

WORKDIR "${HOME}"