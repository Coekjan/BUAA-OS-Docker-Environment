FROM ubuntu:20.04

RUN mkdir /OSLAB
COPY ./OSLAB /OSLAB
RUN apt-get update;\
    apt-get -y upgrade;\
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y tzdata \
                       vim nano \
                       tree \
                       sudo \
                       git \
                       build-essential \
                       screen \
                       tmux \
                       curl \
                       zlib1g \
                       zlib1g-dev \
                       net-tools \
                       shared-mime-info \
                       openssh-server \
                       qemu-system-mips \
                       gcc-multilib \
                       lib32ncurses5-dev \
                       lsb-core \
                       lib32z1 \
                       ctags \
                       gdb \
                       gdb-multiarch \
                       htop \
                       openssh-server
RUN dpkg-reconfigure -f noninteractive tzdata
RUN bash -c "yes | unminimize"

RUN useradd -rm -d /home/scse -s /bin/bash -g root -G sudo -u 1000 scse
RUN echo "scse:scse" | chpasswd

RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
