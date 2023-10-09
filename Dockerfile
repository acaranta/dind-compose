FROM ubuntu:20.04

MAINTAINER Arthur Caranta <arthur@caranta.com>
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

RUN echo "Europe/Paris" > /etc/timezone #&& dpkg-reconfigure tzdata
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl iptables gnupg2

ADD docker.list /etc/apt/sources.list.d
RUN curl -o - https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg |apt-key add -

# Let's start with some basic stuff.
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli

ADD ./dind /usr/local/bin/dind
RUN chmod +x /usr/local/bin/dind

ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

RUN apt install -y python3-pip supervisor
RUN pip3 install --upgrade pip
RUN pip3 install docker-compose

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
