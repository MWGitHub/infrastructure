#!/usr/bin/env bash

apt-get update
apt-get install -y unzip
cd $HOME
wget https://releases.hashicorp.com/vault/0.10.1/vault_0.10.1_linux_amd64.zip
unzip https://releases.hashicorp.com/vault/0.10.1/vault_0.10.1_linux_amd64.zip

vault server -config=vault.hcl
