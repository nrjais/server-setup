#! /bin/bash

DOCKER_COMPOSE_VERSION=1.24.1

apt-get update
apt-get upgrade -y

install_docker() {
  apt-get remove docker docker-engine docker.io containerd runc -y
  apt-get install \
    apt-transport-https ca-certificates curl \
    gnupg-agent software-properties-common -y

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

  apt-get install docker-ce docker-ce-cli containerd.io -y
}

install_compose() {
  curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}

apt-get install fish -y
install_docker
install_compose
apt-get install ./watchexec.deb -y
apt autoremove
