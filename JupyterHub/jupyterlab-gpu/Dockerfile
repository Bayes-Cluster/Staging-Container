# NAME: bayes-cluster/jupyterlab-gpu 
FROM bayes-cluster/jupyterlab-cpu:0.1.1

LABEL org.opencontainers.image.documentation="Oct 08, 2022"
LABEL org.opencontainers.image.authors="Bayes Cluster Maintenance Group"
LABEL org.opencontainers.artifact.description="Bayes Cluster Jupyterlab Image - Statistics/Data Science/Machine Learning/Deep Learning with NVIDIA-GPU Support"
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

ARG NVREPO=https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64
ARG NVREPO_ML=https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gnupg2 \
    && apt-key adv --fetch-keys $NVREPO/3bf863cc.pub \
    && apt-key adv --fetch-keys $NVREPO/7fa2af80.pub \
    && echo "deb $NVREPO /" > /etc/apt/sources.list.d/cuda.list \
    && echo "deb $NVREPO_ML /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        cuda-cudart-11-1=11.1.74-1 \
        cuda-compat-11-1

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf \
    && echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.1"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        cuda-libraries-11-1=11.1.1-1 \
        libnpp-11-1=11.1.2.301-1 \
        cuda-nvtx-11-1=11.1.74-1 \
        libcusparse-11-1=11.3.0.10-1 \
        libcublas-11-1=11.3.0.106-1 \
        libnccl2=2.8.4-1+cuda11.1 \
    && apt-mark hold libcublas-11-1 libnccl2

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "lab"]

# Switch back to bayes to avoid accidental container runs as root
USER bayes

WORKDIR "${HOME}"