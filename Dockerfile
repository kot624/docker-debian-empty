FROM debian:bullseye
ARG DEBIAN_FRONTEND=noninteractive
MAINTAINER Burdzhanadze Konstantin <kot624@mail.ru>
LABEL version="3"
LABEL description="This is an empty operating system"
RUN apt-get -qq update && apt-get -qq --no-install-recommends install sudo nano git openssh-server net-tools iputils-ping
RUN apt-get -qq clean
RUN rm -rf /var/lib/apt/lists/*
RUN sed -i -r 's/^.?PermitRootLogin.*/PermitRootLogin\ yes/g' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN useradd -rm -d /home/kot624 -s /bin/bash -g root -G sudo -u 1000 kot624
RUN usermod -aG sudo kot624
RUN echo "root:ain433455" | chpasswd
RUN echo "kot624:ain433455" | chpasswd

EXPOSE 22

CMD ["service", "ssh", "start", "-D"]
