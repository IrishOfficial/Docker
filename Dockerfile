FROM ubuntu:22.04

LABEL author="Isaac A." maintainer="isaac@isaacs.site"

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 \
    && apt update \
    && apt upgrade -y \
    && apt install -y \
        lib32gcc-s1 \
        lib32stdc++6 \
        libsdl2-2.0-0:i386 \
        libsdl2-2.0-0 \
        unzip \
        curl \
        wget \
        iproute2 \
        libgdiplus \
        ca-certificates \
        libicu70 \
        libc6 \
        libgcc-s1 \
        libssl3 \
        openssl \
    && wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb \
    && dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb \
    && rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb \
    && useradd -d /home/container -m container

USER container

ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./res/entrypoint.sh /entrypoint.sh
COPY ./res/ProcessWrapper /ProcessWrapper

USER root

RUN chmod a+x /ProcessWrapper \
    && chmod a+x /entrypoint.sh

USER container

CMD ["/bin/bash", "/entrypoint.sh"]
