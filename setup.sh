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
