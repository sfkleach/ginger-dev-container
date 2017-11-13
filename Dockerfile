FROM ubuntu:16.10
MAINTAINER Stephen Leach "sfkleach@gmail.com"
ENV REFRESHED_AT 2017-11-13:22:32
RUN apt-get update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git sudo make curl

# Now set up the pre-requisites, which are stored in a slightly odd place right now.
RUN mkdir -p /tmp/setup /tmp/setup/devtools/docker-scripts
WORKDIR /tmp/setup
RUN curl https://raw.githubusercontent.com/Spicery/ginger/development/JumpStart.makefile > JumpStart.makefile
RUN curl https://raw.githubusercontent.com/Spicery/ginger/development/devtools/docker-scripts/install-prerequisites.bsh > devtools/docker-scripts/install-prerequisites.bsh
RUN make -f JumpStart.makefile ubuntu

# And now set up the initial user.
RUN useradd -G sudo --create-home --shell /bin/bash gdev
RUN echo "gdev:gdev" | chpasswd
WORKDIR /home/gdev

# Make that user special
RUN echo "gdev ALL=(root) NOPASSWD: ALL" >> /etc/sudoers

# Set up the mount point
ENV SPICERY_DEV_HOME=/spicery
ENV GINGER_DEV_HOME=/spicery/ginger
RUN mkdir -p ${GINGER_DEV_HOME}
RUN chown -R gdev:gdev ${SPICERY_DEV_HOME}
USER gdev
RUN echo 'export PS1="🐳 "${PS1}' >> /home/gdev/.bashrc
COPY startup.bsh /home/gdev
CMD /bin/bash startup.bsh; /bin/bash
