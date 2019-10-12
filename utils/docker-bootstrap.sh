#!/usr/bin/env bash

docker run                               \
    -it                                  \
    --rm                                 \
    --shm-size 1G                        \
    --cpus 4                             \
    -e OMP_NUM_THREADS=1                 \
    -e MKL_NUM_THREADS=1                 \
    -e USER_UID=$(id -u)                 \
    -e USER_GID=$(id -g)                 \
    -v ${HOME}/data:/data/:ro            \
    -v ${PWD}:/home/bootstrap/workspace/ \
    --gpus '"device=0"'                  \
    bootstrap.pytorch                    \
    "$@"
