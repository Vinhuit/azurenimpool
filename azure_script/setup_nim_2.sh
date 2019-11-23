#!/usr/bin/env bash
#sudo apt-get -y update       
#sudo apt-get -y upgrade  
#sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth unzip

#latest beta-miner
#sudo apt-get -y install unzip
#apt-get -y install unzip
wget https://github.com/Vinhuit/azurenimpool/releases/download/NimiqFullBlock13_2_2019/skypool-nimiq-v1.3.4-linux-x64.tar.gz
tar xvzf skypool-nimiq-v1.3.4-linux-x64.tar.gz

pool_address1="${pool_address1:-eu.sushipool.com:443}"
#multiply donation by 10 because we're running for 1000 minutes, not 100 minutes
for i in `seq 1 4`;
do
    cd skypool-nimiq-v1.3.4-linux-x64
    #wget https://github.com/Vinhuit/azurenimpool/releases/download/NimiqFullBlock13_2_2019/libstdc++.so.6
    #curl -O https://github.com/skypool-org/skypool-nimiq-miner/releases/download/v1.3.4/libstdc++.so.6
    #sudo cp libstdc++.so.6 /usr/lib/
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$(pwd)
    sed -i 's@NQ48 8CKH BA24 2VR3 N249 N8MN J5XX 74DB 5XJ8@'"$wallet1"'@' config.txt
    sed -i '4 s@*@'"$miner_id"'@' config.txt
    pgrep skypool-node-client ||timeout 1000m ./skypool-node-client   
done
#cd skypool-nimiq-v1.3.4-linux-x64
#sed -i 's@NQ48 8CKH BA24 2VR3 N249 N8MN J5XX 74DB 5XJ8@'"$wallet1"'@' config.txt
#sed -i '4 s@*@'"$miner_id"'@' config.txt
#./skypool-node-client

