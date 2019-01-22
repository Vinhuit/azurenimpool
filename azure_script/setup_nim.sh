#!/usr/bin/env bash
#sudo apt-get -y update       
#sudo apt-get -y upgrade  
sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth unzip

#latest beta-miner
wget https://miner.beeppool.org/downloads/beepminer-0.3.4.zip
unzip beepminer-0.3.4.zip

pool_address1="${pool_address1:-eu.sushipool.com:443}"
#multiply donation by 10 because we're running for 1000 minutes, not 100 minutes
let donation*=10

for i in `seq 1 4`;
do
    cd beepminer-0.3.4
    timeout 1000m ./miner --wallet-address="$wallet1" --pool=$pool_address1 --deviceLabel=$miner_id --architecture=sandybridge --miner=20
done
