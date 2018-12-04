#!/bin/sh

printf "

#############################
#    Welcome to your new    #
#     Scribe Masternode     #
#############################

The install has started, follow the progress by
typing the following on the command line:

tail -f /home/scribeuser/01vpsmnlog.txt

" > ~/MASTERNODE_INSTALL_IN_PROGRESS

















sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common libgmp3-dev -y
sudo apt-get install libboost-all-dev -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
sudo apt-get install libminiupnpc-dev -y
sudo apt-get -y install python-virtualenv virtualenv
sudo apt-get install nano jq htop git pwgen libzmq3-dev bc -y




useradd -m -s /bin/bash scribeuser



su - scribeuser bash -c 'wget -O 01vpsscribe.sh https://raw.githubusercontent.com/okpluscoin/scribe-masternode-setup/master/vps-scribe.sh && sh 01vpsscribe.sh'

printf "

#############################
#    Welcome to your new    #
#     01Coin Masternode     #
#############################

The install has finished, find your required masternode key
in the file located here:

/home/scribeuser/01vpsmnlog.txt

" > ~/MASTERNODE_INSTALL_COMPLETE
rm ~/MASTERNODE_INSTALL_IN_PROGRESS
