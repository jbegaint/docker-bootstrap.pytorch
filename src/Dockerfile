ARG PYTORCH_DOCKER_TAG=1.2-cuda10.0-cudnn7-runtime

FROM pytorch/pytorch:${PYTORCH_DOCKER_TAG}

LABEL maintainer="github.com/jbegaint"

# Arguments parsing and variables assignment
ARG GCC_ARCH_OPTS=""

ENV GCC_ARCH_OPTS=${GCC_ARCH_OPTS}

ENV UID=65535
ENV GID=65535

# Create a default user
ENV USER=bootstrap
ENV GROUP=bootstrap
ENV HOME=/home/${USER}

RUN mkdir -p ${HOME}/workspace                                              && \
    groupadd -r ${GROUP} -g ${GID}                                          && \
    useradd -r -u ${UID} -g ${GID} -d ${HOME} -s /sbin/nologin ${USER}      && \
    chown -R ${USER}:${GROUP} ${HOME}

# Install required system packages
RUN set -eux                                                                && \
    apt-get update                                                          && \
    apt-get install -y --no-install-recommends                                 \
    gosu                                                                    && \
    rm -rf /var/lib/apt/lists/*                                             && \
    # verify that the binary works
    gosu nobody true

## Install python requirements
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

## Install faster pillow version ( with SIMD support)
RUN pip uninstall -y pillow                                                 && \
        CC="cc ${GCC_ARCH_OPTS}" pip install -U --force-reinstall              \
        pillow-simd==6.0.0.post0

# Support arbitrary user IDs
ENTRYPOINT ["arbitrary-uid.sh"]

COPY arbitrary-uid.sh /usr/local/bin/

WORKDIR ${HOME}/workspace
