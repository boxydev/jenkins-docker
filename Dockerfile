FROM jenkins/jenkins:lts
MAINTAINER Matthieu Mota <matthieumota@gmail.com>

USER root

RUN apt-get update \
  && apt-get install -y \
  php

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
