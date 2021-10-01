#! /bin/bash
set -e

DOCKER_COMPOSE_VERSION=v2.0.1
WATCHEXEC_VERSION='1.17.1'

apt-get update
apt-get upgrade -y

install_docker() {
  apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

  apt-get update

  apt-get install docker-ce docker-ce-cli containerd.io -y
}

install_compose() {
  PLUGINS=/usr/lib/docker/cli-plugins
  mkdir -p $PLUGINS
  curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o $PLUGINS/docker-compose
  chmod +x $PLUGINS/docker-compose
}

install_envsbst() {
  curl -L https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-$(uname -s)-$(uname -m) -o envsubst
  chmod +x envsubst
  sudo mv envsubst /usr/local/bin
}

install_watchexec() {
  curl -L https://github.com/watchexec/watchexec/releases/download/cli-v${WATCHEXEC_VERSION}/watchexec-${WATCHEXEC_VERSION}-x86_64-unknown-linux-gnu.deb -o /tmp/watchexec.deb
  apt-get install /tmp/watchexec.deb -y
}

apt-get install fish -y
apt-get install rclone -y

install_docker
install_compose
install_envsbst
install_watchexec

apt-get full-upgrade -y

apt autoremove
