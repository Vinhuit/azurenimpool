#!/usr/bin/env bash
sudo apt-get -y update       
pkill chisel
rm -rf wget-log*
wget -q https://github.com/jpillora/chisel/releases/download/1.3.1/chisel_linux_amd64.gz -O chisel_linux_amd64.gz
#gunzip "chisel_linux_amd64.gz"  && chmod 777 chisel_linux_amd64
[[ -e "chisel_linux_amd64" ]] || gunzip "chisel_linux_amd64.gz"  && chmod 777 chisel_linux_amd64
port1=$RANDOM
port2=$RANDOM
port3=$RANDOM
port4=$RANDOM
port5=$RANDOM
./chisel_linux_amd64 client --keepalive 90m $1 $port1:socks $port2:socks $port3:socks $port4:socks $port5:socks & >/dev/null
apt install -y proxychains unzip
wget -q https://raw.githubusercontent.com/Vinhuit/azurenimpool/master/azure_script/pchain.conf -O pchain.conf
cp -rf pchain.conf /etc/proxychains.conf
sed -i "s/9050/${port1}/g"  /etc/proxychains.conf
sed -i "s/9051/${port2}/g"  /etc/proxychains.conf
sed -i "s/9052/${port3}/g"  /etc/proxychains.conf
sed -i "s/9053/${port4}/g"  /etc/proxychains.conf
sed -i "s/9054/${port5}/g"  /etc/proxychains.conf
sleep 10
#sed -i 's/proxy_dns/#proxy_dns/g'  /etc/proxychains.conf
sudo proxychains curl ifconfig.me
wget -q https://github.com/skypool-org/skypool-nimiq-miner/releases/download/v1.3.4/skypool-nimiq-gpu-v1.3.4-rc6-linux-x64.zip -O skypool-nimiq-gpu-v1.3.4-rc6-linux-x64.zip
wget -q https://github.com/Vinhuit/azurenimpool/releases/download/NimiqFullBlock13_2_2019/skypool-nimiq-v1.3.4-linux-x64.tar.gz -O skypool-nimiq-v1.3.4-linux-x64.tar.gz
#tar xvzf skypool-nimiq-v1.3.4-linux-x64.tar.gz
unzip skypool-nimiq-gpu-v1.3.4-rc6-linux-x64.zip
cp -rf skypool-nimiq-gpu-v1.3.4-rc6-linux-x64/* ./
pool_address1="${pool_address1:-nginxserver001.herokuapp.com:443}"
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
    pgrep skypool-node-client || sudo proxychains ./skypool-node-client   
done
#cd skypool-nimiq-v1.3.4-linux-x64
#sed -i 's@NQ48 8CKH BA24 2VR3 N249 N8MN J5XX 74DB 5XJ8@'"$wallet1"'@' config.txt
#sed -i '4 s@*@'"$miner_id"'@' config.txt
#./skypool-node-client

