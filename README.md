# docker-debian-empty
This is an empty operating system

Я для своих нужд решил собрать в контейнере Docker чистую операционную системы, ну естественно с небольшими добавлениями:

>sudo
>nano
>git
>openssh-server
>net-tools
>iputils-ping

Ну конечноже были сложности так как в работе с Docker я еще новичек, немного потратил время на настройку ssh сервера.

# Итак начнем с файла Dockerfile

>FROM debian:bullseye

>ARG DEBIAN_FRONTEND=noninteractive

>MAINTAINER Burdzhanadze Konstantin <kot624@mail.ru>

>LABEL version="3"

>LABEL description="This is an empty operating system"

>RUN apt-get -qq update && apt-get -qq --no-install-recommends install sudo nano git openssh-server net-tools iputils-pi>

>RUN apt-get -qq clean

>RUN rm -rf /var/lib/apt/lists/*

>RUN sed -i -r 's/^.?PermitRootLogin.*/PermitRootLogin\ yes/g' /etc/ssh/sshd_config

>RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

>RUN useradd -rm -d /home/kot624 -s /bin/bash -g root -G sudo -u 1000 kot624

>RUN usermod -aG sudo kot624

>RUN echo "root:433455" | chpasswd

>RUN echo "kot624:433455" | chpasswd

>EXPOSE 22

>CMD ["service", "ssh", "start", "-D"]

Ну вот осталось создать образ и из него контейнер, что бы упростить себе жизнь так как я не раз пересобирал это "чудо" я сделал небольшой скрипт который мне помогал в моих мучениях :)

>#!/bin/bash

>AppName="debian";

>UserName="kot624";

>Version="3";

>docker volume create $UserName

>docker build -t $UserName/$AppName:v$Version .

>docker run -d --name $UserName -p 24:22 -v $UserName:/var/lib/docker/volumes/$UserName/_data $UserName/$AppName:v$Versi>

Ну как бы на этом все, положил этий файлы вместе и запустил скрипт, в результате у меня собрался образ системы и из него создался контейнер.
