# NAME baeys-cluster/jupyterlab
FROM registry.cn-hangzhou.aliyuncs.com/bayes-cluster/base:0.1.0

LABEL org.opencontainers.image.documentation="Oct 08, 2022"
LABEL org.opencontainers.image.authors="Bayes Cluster Maintenance Group"
LABEL org.opencontainers.artifact.description="Bayes Cluster Jupyterlab Image - Statistics/Data Science/Machine Learning/Deep Learning"
LABEL org.opencontainers.image.source https://github.com/Bayes-Cluster/Staging-Container
LABEL org.opencontainers.image.documentation="https://github.com/Bayes-Cluster/Staging-Container"
LABEL org.opencontainers.image.title="jupyterhub"
LABEL org.opencontainers.image.version="3.0.0"

# Pre-requisites
SHELL ["/bin/bash", "-O", "extglob", "-c"]
USER root

# Install NodeJS & NPM
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nodejs \
        npm && \
        apt-get clean all && rm -rf /var/lib/apt/lists/* 

RUN python3 -m pip install jupyter \
            jupyterlab \
            jupyterhub \
            jupyterlab-git \
            jupyterlab-drawio \
            jupyterlab-kernelspy \
            jupyterlab-system-monitor \
            jupyter-resource-usage \
            nbdime

# jupyterlab_slurm jupyter-resource-usage
USER bayes

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "lab"]

