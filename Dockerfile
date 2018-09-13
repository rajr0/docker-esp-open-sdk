FROM ubuntu:14.04
MAINTAINER RajR

RUN apt-get update && \
    apt-get install -y \
      make unrar-free autoconf automake libtool gcc g++ gperf \
      flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
      sed git unzip bash help2man wget bzip2 \
      git

RUN useradd --home-dir /home/nonroot --uid 1000 nonroot \
    && echo -n 'nonroot:password' | chpasswd \
    && mkdir /home/nonroot && chown nonroot:nonroot /home/nonroot \
    && echo "nonroot ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER nonroot
WORKDIR /home/nonroot

RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git

RUN cd esp-open-sdk && make STANDALONE=y && make

RUN echo "export PATH=/home/nonroot/esp-open-sdk/xtensa-lx106-elf/bin:$PATH" > /home/nonroot/.bashrc

CMD bash
