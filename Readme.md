# bootstrap.pytorch docker image

Docker image for `bootstrap.pytorch`, a high-level extension for deep learning
projects with PyTorch ([github](https://github.com/Cadene/bootstrap.pytorch)).

The image is based on the official PyTorch docker image. It provides
`bootstrap.pytorch` and `Pillow-SIMD`.

## Requirements
* [docker](https://docs.docker.com/install/)
* [nvidia-docker](https://nvidia.github.io/nvidia-docker/)
* ([docker post-install](https://docs.docker.com/install/linux/linux-postinstall/))

## Building

```
git clone https://github.com/jbegaint/docker-bootstrap.pytorch && \
cd docker-bootstrap.pytorch                                    && \
make build
```

Options:
* the PyTorch docker tag can be set via the `PYTORCH_DOCKER_TAG` environment
  variable (see the list of tags on [docker
  hub](https://hub.docker.com/r/pytorch/pytorch/tags))

## Usage

* use the docker `--gpus` option to specify which GPUs to use (see the [official
  nvidia doc](https://github.com/NVIDIA/nvidia-docker#usage) for some examples)
* the `USER_UID` and `USER_GID` environment variables can be set when mounting
  volumes, to align host and guest filesystem user permissions
* see `utils/docker-bootstrap.sh` for a full command example

## Examples

### Interactive python shell

```
docker run -it --rm bootstrap.pytorch python
```

### PyTorch command

```
docker run -it                                                        \
           --rm                                                       \
           --gpus '"device=all"'                                      \
           bootstrap.pytorch                                          \
           python -c 'import torch; print(torch.cuda.is_available())'
```

### Calling bootstrap.pytorch
```
docker run                               \
    -it                                  \
    --rm                                 \
    --shm-size 1G                        \
    -e USER_UID=$(id -u)                 \
    -e USER_GID=$(id -g)                 \
    -v ${HOME}/data:/data/:ro            \
    -v ${PWD}:/home/bootstrap/workspace/ \
    --gpus '"device=all"'                \
    bootstrap.pytorch                    \
    python -m bootstrap.run --help
```

### Full bootstrap.pytorch example

* Clone bootstrap mnist example:
```
git clone https://github.com/Cadene/mnist.bootstrap.pytorch/ && \
cd mnist.bootstrap.pytorch
```

* Get `docker run` wrapper script:
```
wget https://raw.githubusercontent.com/jbegaint/docker-bootstrap.pytorch/master/utils/docker-bootstrap.sh && \
chmod 755 docker-bootstrap.sh
```

* Train for one epoch:
```
./docker-bootstrap.sh python -m bootstrap.run \
        -o mnist/options/adam.yaml            \
        --engine.nb_epochs 1
```

* List all training options:
```
./docker-bootstrap.sh python -m bootstrap.run \
        -o mnist/options/adam.yaml            \
        --help
```

* View results:
```
./docker-bootstrap.sh python -m bootstrap.compare -d logs/mnist/adam/
```
