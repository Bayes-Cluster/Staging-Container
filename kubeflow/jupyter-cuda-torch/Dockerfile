ARG TARGETPLATFORM
ARG REGISTRY_PREFIX

FROM --platform=$TARGETPLATFORM $REGISTRY_PREFIX/kubeflow:latest-jupyter-base

ARG PYTORCH_VERSION=2.5.1
ARG TORCHAUDIO_VERSION=2.5.1
ARG TORCHVISION_VERSION=0.20.1

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=12.4"

RUN python3 -m pip install --quiet --no-cache-dir --index-url https://download.pytorch.org/whl/cu124 \
  torch==${PYTORCH_VERSION} \
  torchaudio==${TORCHAUDIO_VERSION} \
  torchvision==${TORCHVISION_VERSION}
RUN python3 -m pip install --quiet --no-cache-dir --index-url https://download.pytorch.org/whl/cu124 \
  torch==2.5.1 \
  torchaudio===${TORCHAUDIO_VERSION} \
  torchvision===${TORCHVISION_VERSION}

RUN mamba install -y -q \
    bokeh==3.6.3 \
    cloudpickle==3.1.1 \
    dill==0.3.9 \
    ipympl==0.9.6 \
    matplotlib==3.10.0 \
    numpy==1.26.4 \
    pandas==2.2.3 \
    scikit-image==0.25.1 \
    scikit-learn==1.6.1 \
    scipy==1.15.1 \
    seaborn==0.13.2 \
    xgboost==2.1.4 \
 && mamba clean -a -f -y

RUN mamba install -y -q \
    bokeh==3.6.3 \
    cloudpickle==3.1.1 \
    dill==0.3.9 \
    ipympl==0.9.6 \
    matplotlib==3.10.0 \
    numpy==1.26.4 \
    pandas==2.2.3 \
    scikit-image==0.25.1 \
    scikit-learn==1.6.1 \
    scipy==1.15.1 \
    seaborn==0.13.2 \
    xgboost==2.1.4 \
 && mamba clean -a -f -y

RUN mamba install -y -q \
    bokeh==3.6.3 \
    cloudpickle==3.1.1 \
    dill==0.3.9 \
    ipympl==0.9.6 \
    matplotlib==3.10.0 \
    numpy==1.26.4 \
    pandas==2.2.3 \
    scikit-image==0.25.1 \
    scikit-learn==1.6.1 \
    scipy==1.15.1 \
    seaborn==0.13.2 \
    xgboost==2.1.4 \
 && mamba clean -a -f -y

COPY --chown==${NB_USER}:${NB_GID} requirements.txt /tmp 
RUN python3 -m pip install -r /tmp/requirements.txt --quiet --no-cache-dir \
  && rm -f /tmp/requirements.txt
