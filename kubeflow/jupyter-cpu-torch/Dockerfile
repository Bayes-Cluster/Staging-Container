ARG TARGETPLATFORM
ARG REGISTRY_PREFIX
ARG TARGETPLATFORM

FROM --platorm=$TARGETPLATFORM $REGISTRY_PREFIX/kubeflow:latest-jupyter-base

ARG PYTORCH_VERSION=2.5.1
ARG TORCHAUDIO_VERSION=2.5.1
ARG TORCHVISION_VERSION=0.20.1

RUN python3 -m pip install --quiet --no-cache-dir \ 
  torch==${PYTORCH_VERSION} \
  torchaudio=${TORCHAUDIO_VERSION} \
  torchvision=${TORCHVISION_VERSION}

COPY --chown${NB_USER}:${NB_GID} requirements.txt /tmp 
RUN python3 -m pip install -r /tmp/requirements.txt --quiet --no-cache-dir \
  && rm -f /tmp/requirements.txt
