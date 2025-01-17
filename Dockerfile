FROM ubuntu:22.04

MAINTAINER Arthur Caranta <arthur@caranta.com>
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV COMPOSER_VER v2.29.1

RUN echo "Europe/Paris" > /etc/timezone #&& dpkg-reconfigure tzdata
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl iptables gnupg2 lsb-release

# ADD docker.list /etc/apt/sources.list.d
RUN echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN curl -o - https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg |apt-key add -

# Let's start with some basic stuff.
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli

ADD ./dind /usr/local/bin/dind
RUN chmod +x /usr/local/bin/dind

ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

RUN apt install -y python3-pip supervisor
RUN pip3 install --upgrade pip
# RUN pip3 install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/${COMPOSER_VER}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
