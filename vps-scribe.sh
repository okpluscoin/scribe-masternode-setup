#!/bin/bash
# MadStu's Small Install Script
cd ~
rm new01vps*
wget https://raw.githubusercontent.com/okpluscoin/scribe-masternode-setup/master/new-vps-scribe-install.sh
chmod 777 new01vpsscribeinstall.sh && rm 01vpsscribe.sh
sed -i -e 's/\r$//' new01vpsscribeinstall.sh
./new01vpsscribeinstall.sh
