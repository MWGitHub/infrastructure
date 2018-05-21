#!/usr/bin/env bash

apt update
apt install -y unzip wget ufw
add-apt-repository ppa:certbot/certbot
apt update
apt install certbot
ufw allow 80

cd "$HOME"
wget https://releases.hashicorp.com/vault/0.10.1/vault_0.10.1_linux_amd64.zip
unzip vault_0.10.1_linux_amd64.zip

mv vault /usr/local/bin
vault server -config=config/vault.hcl
vault write sys/auth/secrets type=userpass
vault operator init
