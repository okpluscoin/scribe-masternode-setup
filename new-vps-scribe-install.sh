#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

THISHOST=$(hostname -s) >> ~/01vpsmnlog.txt 2>&1
EXIP=$(hostname -i) >> ~/01vpsmnlog.txt 2>&1
BLKS=$(curl https://explorer.scribe.network/api/getblockcount) >> ~/01vpsmnlog.txt 2>&1

checkrunning () {

while ! ~/scribe/scribe-cli getinfo; do
	echo "....." >> ~/01vpsmnlog.txt 2>&1
	sleep 20
done

}

if [ -e /home/scribeuser/.scribecore ]
then

	printf "ALREADY INSTALLED or CURRENTLY RUNNING" > ~/ALREADYINSTALLED

else

	printf "

	#############################
	#    Welcome to your new    #
	#     Scribe Masternode     #
	#############################

	The install has started, follow the progress by  
	typing the following on the command line:

	tail -f /home/scribeuser/01vpsmnlog.txt





	#############################
	#  Install log follows:...  #
	#############################

	" > ~/01vpsmnlog.txt 2>&1

	cd ~ >> ~/01vpsmnlog.txt 2>&1
	wget -O scribe.tar.gz https://github.com/scribenetwork/scribe/releases/download/v0.2/scribe-ubuntu-16.04-x64.tar.gz >> ~/01vpsmnlog.txt 2>&1
	tar -xvzf scribe.tar.gz >> ~/01vpsmnlog.txt 2>&1
	mkdir ~/scribe 2>&1
	cp scribe-ubuntu-16.04-x64/usr/local/bin/scribe-cli . >> ~/scribe/scribe-cli 2>&1
	cp scribe-ubuntu-16.04-x64/usr/local/bin/scribed . >> ~/scribe/scribed 2>&1
	chmod +x ~/scribe/scribe-cli
	chmod +x ~/scribe/scribed
	rm -rf scribe-ubuntu-16.04-x64 >> ~/01vpsmnlog.txt 2>&1
	rm scribe.tar.gz >> ~/01vpsmnlog.txt 2>&1

	mkdir ~/.scribecore >> ~/01vpsmnlog.txt 2>&1
	RPCU=$(pwgen -1 4 -n) >> ~/01vpsmnlog.txt 2>&1
	PASS=$(pwgen -1 14 -n) >> ~/01vpsmnlog.txt 2>&1
	printf "rpcuser=rpc$RPCU\nrpcpassword=$PASS\nrpcport=8899\nrpcthreads=8\nrpcallowip=127.0.0.1\nbind=$EXIP:8800\nmaxconnections=8\ngen=0\nexternalip=$EXIP\ndaemon=1\n\n" > ~/.scribecore/scribe.conf

	~/scribe/scribed -daemon >> ~/01vpsmnlog.txt 2>&1

checkrunning

	echo "Generating Masternode Key..." >> ~/01vpsmnlog.txt 2>&1
	sleep 15
	echo "....." >> ~/01vpsmnlog.txt 2>&1


	MKEY=$(~/scribe/scribe-cli masternode genkey) >> ~/01vpsmnlog.txt 2>&1
	~/scribe/scribe-cli stop >> ~/01vpsmnlog.txt 2>&1


	printf "masternode=1\nmasternodeprivkey=$MKEY\n\n" >> ~/.scribecore/scribe.conf

	

	sleep 25
	echo "Starting up..." >> ~/01vpsmnlog.txt 2>&1
	sleep 10
	echo "....." >> ~/01vpsmnlog.txt 2>&1

	

	~/scribe/scribed -daemon >> ~/01vpsmnlog.txt 2>&1
	sleep 5
	echo "Downloading Blockchain..." >> ~/01vpsmnlog.txt 2>&1
	sleep 10
	echo "....." >> ~/01vpsmnlog.txt 2>&1

checkrunning
	
	cd ~
	git clone https://github.com/scribenetwork/sentinel.git >> ~/01vpsmnlog.txt 2>&1
	cd sentinel >> ~/01vpsmnlog.txt 2>&1
	virtualenv ./venv >> ~/01vpsmnlog.txt 2>&1
	./venv/bin/pip install -r requirements.txt >> ~/01vpsmnlog.txt 2>&1

	crontab -l > mycron
	echo "* * * * * cd /home/scribeuser/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1" >> mycron
	crontab mycron
	rm mycron
	sleep 10
	cd ~/sentinel >> ~/01vpsmnlog.txt 2>&1

	./venv/bin/py.test ./test >> ~/01vpsmnlog.txt 2>&1
	
	rm ~/.scribecore/mncache.dat >> ~/01vpsmnlog.txt 2>&1
	rm ~/.scribecore/mnpayments.dat >> ~/01vpsmnlog.txt 2>&1
	~/scribe/scribed -daemon -reindex >> ~/01vpsmnlog.txt 2>&1
	
checkrunning
	
	
while true; do
WALLETBLOCKS=$(~/scribe/scribe-cli getblockcount) >> ~/01vpsmnlog.txt 2>&1

#if (( $(echo "$WALLETBLOCKS < $BLKS" | bc -l) ))
if [ "$WALLETBLOCKS" -lt "$BLKS" ]
then
	echo "  ..." >> ~/01vpsmnlog.txt 2>&1
	echo "    Blocks so far: $WALLETBLOCKS / $BLKS" >> ~/01vpsmnlog.txt 2>&1
	sleep 5
else
	echo "      Complete!..." >> ~/01vpsmnlog.txt 2>&1
	echo "    Blocks so far: $WALLETBLOCKS / $BLKS" >> ~/01vpsmnlog.txt 2>&1
	sleep 5
	break
fi
done
	
	
while true; do
ARRAY=$(~/scribe/scribe-cli mnsync status)
echo "$ARRAY" > getinfo.json
AssetID=$(jq '.AssetID' getinfo.json)
#if (( $(echo "$AssetID < 999" | bc -l) ))
if [ "$AssetID" -lt 999 ]
then
	echo "  ..." >> ~/01vpsmnlog.txt 2>&1
	echo "          AssetID: $AssetID" >> ~/01vpsmnlog.txt 2>&1
	sleep 5
else
	echo "      Complete!..." >> ~/01vpsmnlog.txt 2>&1
	echo "          AssetID: $AssetID" >> ~/01vpsmnlog.txt 2>&1
	sleep 5
	break
fi
done
	

	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo " " >> ~/01vpsmnlog.txt 2>&1
	~/scribe/scribe-cli mnsync status >> ~/01vpsmnlog.txt 2>&1
	echo " " >> ~/01vpsmnlog.txt 2>&1




	sleep 3 



	echo "This is what should go on your windows wallet masternode.conf" >> ~/01vpsmnlog.txt 2>&1
	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo "$THISHOST $EXIP:8800 $MKEY TXID VOUT" >> ~/01vpsmnlog.txt 2>&1
	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo "Your server hostname is $THISHOST and you can change it to MN1 or MN2 or whatever you like" >> ~/01vpsmnlog.txt 2>&1
	echo " " >> ~/01vpsmnlog.txt 2>&1
	sleep 3
	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo "  - wait for 15 confirmations then you can Start Alias in the windows wallet!" >> ~/01vpsmnlog.txt 2>&1
	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo "       Thanks for using the 01VPS.net install service" >> ~/01vpsmnlog.txt 2>&1
	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo " -- END --"  >> ~/01vpsmnlog.txt 2>&1
	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo " Pres Ctrl+c to stop tailing this log file" >> ~/01vpsmnlog.txt 2>&1


	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo "$THISHOST $EXIP:8800 $MKEY TXID VOUT" >> ~/01vpsmnlog.txt 2>&1

	echo " " >> ~/01vpsmnlog.txt 2>&1
	echo "$THISHOST $EXIP:8800 $MKEY TXID VOUT" > ~/masternode.conf 2>&1
	
	# curl --data "exip=$EXIP&mkey=$MKEY&assetid=$AssetID&mn=SCRIBE&hostname=$THISHOST&port=8800&" http://01vps.net/mninstalled.php >> ~/01vpsmnlog.txt 2>&1
fi

rm new01vpsscribeinstall.sh
