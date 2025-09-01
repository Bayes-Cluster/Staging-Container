ARG TARGETPLATFORM
ARG REGISTRY_PREFIX

FROM --platform=$TARGETPLATFORM $REGISTRY_PREFIX/kubeflow:latest-jupyter-base

ARG PYTORCH_VERSION=2.5.1
ARG TORCHAUDIO_VERSION=2.5.1
ARG TORCHVISION_VERSION=0.20.1

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=12.4"

RUN python3 -m pip install --quiet --no-cache-dir --index-url https://download.pytorch.org/whlcu124 \ 
  torch==${PYTORCH_VERSION} \
  torchaudio=${TORCHAUDIO_VERSION} \
  torchvision=${TORCHVISION_VERSION}

COPY --chown${NB_USER}:${NB_GID} requirements.txt /tmp 
RUN python3 -m pip install -r /tmp/requirements.txt --quiet --no-cache-dir \
  && rm -f /tmp/requirements.txt
