FROM ubuntu:16.10
MAINTAINER Stephen Leach "sfkleach@gmail.com"
ENV REFRESHED_AT 2017-07-13
RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git sudo make
RUN useradd -G sudo --create-home --shell /bin/bash gdev
RUN echo "gdev:gdev" | chpasswd
RUN mkdir -p /home/gdev/projects/Spicery
WORKDIR /home/gdev/projects/Spicery
RUN git clone https://github.com/Spicery/ginger.git
WORKDIR ginger
RUN git checkout --track origin/development
RUN make -f JumpStart.makefile ubuntu
RUN make -f JumpStart.makefile configure
RUN make install
RUN chown -R gdev .
WORKDIR /home/gdev
ENV SPICERY_HOME=/home/gdev/projects/Spicery
ENV GINGER_HOME=/home/gdev/projects/Spicery/ginger
USER gdev
RUN echo 'export PS1="🐳 "${PS1}' >> /home/gdev/.bashrc
CMD /bin/bash
