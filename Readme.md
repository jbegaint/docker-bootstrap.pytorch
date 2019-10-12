# bootstrap.pytorch Docker image

## Requirements
* [docker](https://docs.docker.com/install/)
* [nvidia-docker](https://nvidia.github.io/nvidia-docker/)
* ([docker post-install](https://docs.docker.com/install/linux/linux-postinstall/))

## Building

* clone this repository
* `make build`

Options:
* the PyTorch docker tag can be set via the `PYTORCH_DOCKER_TAG` environment
  variable

## Usage

### Interactive python shell

```
docker run -i --rm -e USER_UID=$(id -u) -e USER_GID$=(id -g) bootstrap.pytorch python
```

### Bootstrap example

* `git clone https://github.com/Cadene/mnist.bootstrap.pytorch/`
* `cd mnist.bootstrap.pytorch`
* download the `docker-bootstrap.sh` script from the `examples directory`
* `./docker-bootstrap.sh python -m bootstrap.run \
        -o mnist/options/adam.yaml               \
        --engine.nb_epochs 1`
* `./docker-bootstrap.sh python -m bootstrap.compare -d logs/mnist/adam/`
