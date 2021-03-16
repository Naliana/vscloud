#!/bin/sh
#Steps
#1 install
curl -fsSL https://code-server.dev/install.sh | sh

#2 self signed cert
sed -i.bak 's/cert: false/cert: true/' ~/.config/code-server/config.yaml

sed -i.bak 's/bind-addr: 127.0.0.1:8080/bind-addr: 0.0.0.0:443/' ~/.config/code-server/config.yaml

sudo setcap cap_net_bind_service=+ep /usr/lib/code-server/lib/node

sudo systemctl enable --now code-server@$USER
#3 run the server
#code-server #+ path to repo for opening specific repos (variable)
sudo yum install git -y
