# Makefile for building and pushing Kubeflow images

# Environment variables
REGISTRY_PREFIX := terencelau
TARGETPLATFORM := linux/amd64
PROJECT_NAME := kubeflow
BASE_IMAGE := ubuntu
BASE_IMAGE_VERSION := 24.04
IMAGE_NAME := localhost:5000/terencelau/kubeflow
JUPYTER_VERSION := 7.3.2
JUPYTERLAB_VERSION := 4.3.5
NODE_MAJOR_VERSION := 20
MINIFORGE_VERSION := 25.3.1-0
PIP_VERSION := 24.3.1
PYTHON_VERSION := 3.11.11
CUDA_VERSION := 12.4
PYTORCH_VERSION := 2.5.1
TORCHAUDIO_VERSION := 2.5.1
TORCHVISION_VERSION := 0.20.1
CODESERVER_VERSION := 4.103.2


# Dynamic image tags
BASE_IMAGE_TAG := $(PROJECT_NAME)-$(BASE_IMAGE)-$(BASE_IMAGE_VERSION)
JUPYTER_BASE_IMAGE_TAG := $(PROJECT_NAME)-$(BASE_IMAGE)-$(BASE_IMAGE_VERSION)-jupyter-$(JUPYTER_VERSION)
JUPYTER_CUDA_PYTORCH_IMAGE_TAG := $(PROJECT_NAME)-$(BASE_IMAGE)-$(BASE_IMAGE_VERSION)-jupyter-$(JUPYTER_VERSION)-cuda-$(CUDA_VERSION)-pytorch-$(PYTORCH_VERSION)
CODESERVER_IMAGE_TAG := $(PROJECT_NAME)-$(BASE_IMAGE)-$(BASE_IMAGE_VERSION)-code-server-$(CODESERVER_VERSION)

.PHONY: all build-base push-base build-jupyter-base push-jupyter-base build-jupyter-cuda-pytorch push-jupyter-cuda-pytorch

# Default target
build-all: build-base build-jupyter-base build-jupyter-cuda-pytorch
push-all: push-base push-jupyter-base push-jupyter-cuda-pytorch

# Build base image
build-base:
	nerdctl build \
		-f base/Dockerfile \
		-t $(IMAGE_NAME):$(BASE_IMAGE_TAG) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg BASE_IMAGE_VERSION=$(BASE_IMAGE_VERSION) \
		--build-arg MINIFORGE_VERSION=$(MINIFORGE_VERSION) \
		--build-arg PIP_VERSION=$(PIP_VERSION) \
		--build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
		base
	nerdctl tag $(IMAGE_NAME):$(BASE_IMAGE_TAG) $(IMAGE_NAME):latest-base

# Push base image
push-base:
	nerdctl push $(IMAGE_NAME):$(BASE_IMAGE_TAG)
	nerdctl push $(IMAGE_NAME):latest-base

# Build jupyter-base image
build-jupyter-base: build-base
	nerdctl build \
		-f jupyter/Dockerfile \
		-t $(IMAGE_NAME):$(JUPYTER_BASE_IMAGE_TAG) \
		--build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
		--build-arg PROJECT_NAME=$(PROJECT_NAME) \
		--build-arg REGISTRY_PREFIX=$(REGISTRY_PREFIX) \
		--build-arg JUPYTER_VERSION=$(JUPYTER_VERSION) \
		--build-arg JUPYTERLAB_VERSION=$(JUPYTERLAB_VERSION) \
		--build-arg MINIFORGE_VERSION=$(MINIFORGE_VERSION) \
		--build-arg NODE_MAJOR_VERSION=$(NODE_MAJOR_VERSION) \
		--build-arg PIP_VERSION=$(PIP_VERSION) \
		--build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
		jupyter
	nerdctl tag $(IMAGE_NAME):$(JUPYTER_BASE_IMAGE_TAG) $(IMAGE_NAME):latest-jupyter-base

# Push jupyter-base image
push-jupyter-base:
	nerdctl push $(IMAGE_NAME):$(JUPYTER_BASE_IMAGE_TAG)
	nerdctl push $(IMAGE_NAME):latest-jupyter-base

# Build jupyter-cuda-pytorch image
build-jupyter-cuda-pytorch: build-jupyter-base
	nerdctl build \
		-f jupyter-cuda-torch/Dockerfile \
		-t $(IMAGE_NAME):$(JUPYTER_CUDA_PYTORCH_IMAGE_TAG) \
		--build-arg BASE_IMAGE_TAG=$(JUPYTER_BASE_IMAGE_TAG) \
		--build-arg PROJECT_NAME=$(PROJECT_NAME) \
		--build-arg REGISTRY_PREFIX=$(REGISTRY_PREFIX) \
		--build-arg CUDA_VERSION=$(CUDA_VERSION) \
		--build-arg PYTORCH_VERSION=$(PYTORCH_VERSION) \
		--build-arg TORCHAUDIO_VERSION=$(TORCHAUDIO_VERSION) \
		--build-arg TORCHVISION_VERSION=$(TORCHVISION_VERSION) \
		jupyter-cuda-torch
	nerdctl tag $(IMAGE_NAME):$(JUPYTER_CUDA_PYTORCH_IMAGE_TAG) $(IMAGE_NAME):latest-jupyter-cuda-pytorch

# Push jupyter-cuda-pytorch image
push-jupyter-cuda-pytorch:
	nerdctl push $(IMAGE_NAME):$(JUPYTER_CUDA_PYTORCH_IMAGE_TAG)
	nerdctl push $(IMAGE_NAME):latest-jupyter-cuda-pytorch

build-code-server: build-base
	nerdctl build \
		-f code-server/Dockerfile \
		-t $(IMAGE_NAME):$(CODESERVER_IMAGE_TAG) \
		--build-arg BASE_IMAGE_TAG=$(BASE_IMAGE_TAG) \
		--build-arg PROJECT_NAME=$(PROJECT_NAME) \
		--build-arg REGISTRY_PREFIX=$(REGISTRY_PREFIX) \
		--build-arg CUDA_VERSION=$(CUDA_VERSION) \
		--build-arg PYTORCH_VERSION=$(PYTORCH_VERSION) \
		--build-arg TORCHAUDIO_VERSION=$(TORCHAUDIO_VERSION) \
		--build-arg TORCHVISION_VERSION=$(TORCHVISION_VERSION) \
		--build-arg CODESERVER_VERSION=$(CODESERVER_VERSION) \
		code-server
	nerdctl tag $(IMAGE_NAME):$(PROJECT_NAME)-code-server-$(CODESERVER_VERSION) $(IMAGE_NAME):latest-code-server

push-code-server:
	nerdctl push $(IMAGE_NAME):$(CODESERVER_IMAGE_TAG)
	nerdctl push $(IMAGE_NAME):latest-code-server
