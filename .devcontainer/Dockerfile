FROM debian:bookworm-slim

ARG HOST_UID=501
ARG HOST_GID=20

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        nodejs \
        npm \
    && rm -rf /var/lib/apt/lists/*

RUN if ! getent group ${HOST_GID} >/dev/null; then groupadd -g ${HOST_GID} devgroup; fi \
    && useradd -m -u ${HOST_UID} -g ${HOST_GID} -s /bin/bash dev

USER dev
WORKDIR /home/dev
