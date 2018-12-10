#!/bin/bash

HOSTNAME="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')"

sleep 1
wget -O - https://repo.saltstack.com/apt/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
sleep 1
echo -e 'deb http://repo.saltstack.com/apt/debian/9/amd64/latest stretch main'|sudo tee /etc/apt/sources.list.d/saltstack.list
sleep 1
sudo apt-get update
sleep 1
sudo apt-get -y install salt-minion salt-master
sleep 1
echo -e 'master: '$HOSTNAME'\nid: orja'|sudo tee /etc/salt/minion
sleep 1
sudo systemctl restart salt-minion.service
sleep 5
sudo salt-key -A --yes
sleep 1
sudo salt '*' state.apply
echo "All done(maybe)"
