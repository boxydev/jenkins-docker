FROM jenkins/jenkins:lts
MAINTAINER Matthieu Mota <matthieumota@gmail.com>

ARG DOCKER_VERSION="18.06.1"
RUN curl -sSL https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz \
    | tar -zxC /tmp/ \
    && cp /tmp/docker/docker /usr/local/bin \
    && rm -rf /tmp/docker
RUN groupadd -g 999 docker && usermod -aG docker jenkins

RUN apt-get update \
    && apt-get install -y apt-transport-https \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y php-cli \
    && rm -rf /var/lib/apt/lists/*

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
