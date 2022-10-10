# NAME: bayes-cluster/jupyterlab-gpu 
FROM registry.cn-hangzhou.aliyuncs.com/bayes-cluster/upyterlab-cpu:0.1.0

LABEL org.opencontainers.image.documentation="Oct 08, 2022"
LABEL org.opencontainers.image.authors="Bayes Cluster Maintenance Group"
LABEL org.opencontainers.artifact.description="Bayes Cluster Jupyterlab Image - Statistics/Data Science/Machine Learning/Deep Learning with NVIDIA-GPU Support"
LABEL org.opencontainers.image.source https://github.com/Bayes-Cluster/Staging-Container
LABEL org.opencontainers.image.documentation="https://github.com/Bayes-Cluster/Staging-Container"
LABEL org.opencontainers.image.title="jupyterhub"
LABEL org.opencontainers.image.version="3.0.0"

# Pre-requisites
SHELL ["/bin/bash", "-O", "extglob", "-c"]
USER root
ENV NVARCH=x86_64
ARG TARGETARCH=amd64
ENV NVIDIA_REQUIRE_CUDA=cuda>=11.8 brand=tesla,driver>=450,driver<451 \
                                    brand=tesla,driver>=470,driver<471 \
                                    brand=unknown,driver>=470,driver<471 \
                                    brand=nvidia,driver>=470,driver<471 \
                                    brand=nvidiartx,driver>=470,driver<471 \
                                    brand=quadrortx,driver>=470,driver<471 \
                                    brand=unknown,driver>=510,driver<511 \
                                    brand=nvidia,driver>=510,driver<511 \
                                    brand=nvidiartx,driver>=510,driver<511 \
                                    brand=quadrortx,driver>=510,driver<511 \
                                    brand=unknown,driver>=515,driver<516 \
                                    brand=nvidia,driver>=515,driver<516 \
                                    brand=nvidiartx,driver>=515,driver<516 \
                                    brand=quadrortx,driver>=515,driver<516

ENV NV_CUDA_CUDART_VERSION=11.8.89-1
ENV NV_CUDA_COMPAT_PACKAGE=cuda-compat-11-8
ENV CUDA_VERSION=11.8.0
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV NV_CUDA_LIB_VERSION=11.8.0-1
ENV NV_NVTX_VERSION=11.8.86-1
ENV NV_LIBNPP_VERSION=11.8.0.86-1
ENV NV_LIBNPP_PACKAGE=libnpp-11-8=11.8.0.86-1
ENV NV_LIBCUSPARSE_VERSION=11.7.5.86-1
ENV NV_LIBCUBLAS_PACKAGE_NAME=libcublas-11-8
ENV NV_LIBCUBLAS_VERSION=11.11.3.6-1
ENV NV_LIBCUBLAS_PACKAGE=libcublas-11-8=11.11.3.6-1
ARG TARGETARCH

# Sourse: https://hub.docker.com/r/nvidia/cuda

RUN apt-get update && \
    apt-get install -y --no-install-recommends  \
    gnupg2 curl ca-certificates &&  \
    curl -fsSLO https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/${NVARCH}/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    apt-get clean all && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
cuda-cudart-11-8=${NV_CUDA_CUDART_VERSION}  \
${NV_CUDA_COMPAT_PACKAGE} \
&& ln -s cuda-11.8 /usr/local/cuda

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cuda-libraries-11-8=${NV_CUDA_LIB_VERSION} \
    ${NV_LIBNPP_PACKAGE} \
    cuda-nvtx-11-8=${NV_NVTX_VERSION} \
    libcusparse-11-8=${NV_LIBCUSPARSE_VERSION} \
    ${NV_LIBCUBLAS_PACKAGE} \
    && rm -rf /var/lib/apt/lists/* # buildkit

RUN apt-mark hold ${NV_LIBCUBLAS_PACKAGE_NAME}

# jupyterlab_slurm jupyter-resource-usage
USER bayes

EXPOSE 8888
ENTRYPOINT ["tini", "--"]
CMD ["jupyter", "lab"]