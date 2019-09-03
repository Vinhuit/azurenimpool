#!/usr/bin/env bash
#sudo apt-get -y update       
#sudo apt-get -y upgrade  
#sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth  nodejs npm
sudo apt -y install unzip
#latest beta-miner
rm -rf beepminer*
wget https://github.com/Beeppool/miner/releases/download/0.6.1/beepminer-0.6.1.zip
unzip beepminer-0.6.1.zip

#pool_address1="${pool_address1:-eu.sushipool.com:443}"
#multiply donation by 10 because we're running for 1000 minutes, not 100 minutes
#let donation*=10
#rm -rf data*
#rm -rf lock*
#wget https://github.com/Vinhuit/azurenimpool/releases/download/NimiqFullBlock13_2_2019/data.mdb -O data.mdb
#wget https://github.com/Vinhuit/azurenimpool/releases/download/NimiqFullBlock13_2_2019/lock.mdb -O lock.mdb
#cp -rf ../index-linux ./
#chmod 777 index-linux
#cd beepminer-0.3.4
#timeout 5s ./miner --wallet-address="$wallet1" --pool=$pool_address1 --deviceLabel=$miner_id --architecture=sandybridge --miner=100
#timeout 5s ./index-linux --wallet-address="$wallet1" --pool==$pool_address1 --protocol=dumb --statistics=1 --miner=100 --extra-data=$miner_id
#cp -rf data.mdb main-full-consensus
#cp -rf lock.mdb main-full-consensus
#timeout 5m ./index-linux --wallet-address="$wallet1" --pool==$pool_address1 --protocol=dumb --statistics=1 --miner=100 --extra-data=$miner_id
for i in `seq 1 4`;
do
    cd beepminer-0.6.1
    #timeout 5s ./miner --wallet-address="$wallet1" --pool=$pool_address1 --deviceLabel=$miner_id --architecture=sandybridge --miner=100
    #cp -rf ../main-full-consensus/data.mdb main-light-consensus
    #cp -rf ../main-full-consensus/lock.mdb main-light-consensus
    mv miner iner
    pgrep iner || ./iner --wallet-address="$wallet1" --pool=$pool_address1 --deviceLabel=$miner_id --type=dumb --miner=$(($(grep -c ^processor /proc/cpuinfo)))
done
