SHELL:=/bin/bash

PYTORCH_DOCKER_TAG?=1.2-cuda10.0-cudnn7-runtime

GCC_ARCH_OPTS := $(shell gcc -march=native -dM -E - < /dev/null \
	| grep AVX2 > /dev/null && echo "-mavx2")

all: build

build:
	cd src; docker build                                     \
		-f Dockerfile                                        \
		-t bootstrap.pytorch:latest                          \
		-t bootstrap.pytorch:${PYTORCH_DOCKER_TAG}           \
		--build-arg GCC_ARCH_OPTS=${GCC_ARCH_OPTS}           \
		--build-arg PYTORCH_DOCKER_TAG=${PYTORCH_DOCKER_TAG} \
		.

.PHONY: all build
