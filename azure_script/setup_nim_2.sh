#!/usr/bin/env bash
#sudo apt-get -y update       
#sudo apt-get -y upgrade  
sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth unzip

#latest beta-miner
wget https://github.com/skypool-org/skypool-nimiq-miner-release/releases/download/v1.3.4/skypool-nimiq-v1.3.4-linux-x64.zip
unzip skypool-nimiq-v1.3.4-linux-x64.zip

pool_address1="${pool_address1:-eu.sushipool.com:443}"
#multiply donation by 10 because we're running for 1000 minutes, not 100 minutes

cd skypool-nimiq-v1.3.4-linux-x64
sed -i 's@NQ48 8CKH BA24 2VR3 N249 N8MN J5XX 74DB 5XJ8@'"$wallet1"'@' config.txt
sed -i 's@*@'"$name"'@' config.txt
./skypool-node-client

