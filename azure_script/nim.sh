#!/usr/bin/env bash
# LICENSE
#
# This code is using the No license license.
# Which means you are allowed to use the software.
# You are not allowed the modify / copy the code without the permission from the owner.
# For more information visit: https://choosealicense.com/no-permission/
# - (c) 2018 @joewandy
# - (c) 2018 @brantje
# Copyright @ SushiPool.com 2018

BLUE="$( echo -e "\e[36m" )"
GREEN="$( echo -e "\e[92m" )"
YELLOW="$( echo -e "\e[93m" )"
MAGENTA="$( echo -e "\e[95m" )"
RED="$( echo -e "\e[91m" )"
NC='\033[0m' # No Color
INSTALL_PATH='$PATH'

if [[ $# -eq 0 ]]; then
  echo -e "${MAGENTA}SushiPool${NC} makes mining ${YELLOW}Nimiq${NC} easy!"
  echo -e "Device Statistics are available via www.SushiPool.com"
  echo -e "You can use the following commands:"
  echo -e "${BLUE}sushipool status - Shows miner logs"
  echo -e "${BLUE}sushipool start${NC} - Start miner"
  echo -e "${BLUE}sushipool restart${NC} - Restart miner"
  echo -e "${BLUE}sushipool stop${NC} - Stop miner"
  echo -e "${BLUE}sushipool reset${NC} - Remove peer-key, wallet and main-light-consensus"
  echo -e "${BLUE}sushipool set [address|threads|name]${NC} - Set wallet, threads or name"
  echo -e "${BLUE}sushipool uninstall${NC} - Uninstall miner & service"
fi

if [[ $1 = "status" ]]; then
    journalctl --no-pager -o cat -f -u sushipool-miner.service
fi


if [[ $1 = "stop" ]]; then
    echo "Please wait while miner is being stopped"
    service sushipool-miner stop
fi

if [[ $1 = "start" ]]; then
    echo -e "Now starting ${MAGENTA}sushipool${NC} miner, use ${BLUE}sushipool status${NC} to show logs"
    service sushipool-miner start
fi

if [[ $1 = "restart" ]]; then
    echo -e "Restarting ${MAGENTA}sushipool${NC} miner"
    service sushipool-miner restart
fi


if [[ $1 = "uninstall" ]]; then
    echo -e "Sorry to see you go, no more sushi for you."
    systemctl disable sushipool-miner.service
    cd ${INSTALL_PATH}/..
    DIR=`pwd`
    cd ~
    rm /etc/systemd/system/sushipool-miner.service
    rm -rf ${DIR}
    rm -- "$0"
fi

if [[ $1 = "reset" ]]; then
    sushipool stop
    echo "Removing folders peer-key, wallet and main-light-consensus"
    rm -rf ${INSTALL_PATH}/peer-key
    rm -rf ${INSTALL_PATH}/main-light-consensus
    rm -rf ${INSTALL_PATH}/wallet


fi

if [[ $1 = "set" ]]; then
    if [ -z $1 ] && [ -z $2 ]; then
        echo -e "${BLUE}sushipool set [address|threads|name]${NC} - Set wallet, threads or name"
    fi

    if [[ $2 = "address" ]]; then
        ADDRESS=${@:3}
        LENGTH=${#ADDRESS}
        REQUIRED_LENGTH=44
        if [ "$LENGTH" != "$REQUIRED_LENGTH" ]; then
            echo -e "${RED}Invalid address length${NC}"
        fi
        rm -rf ${INSTALL_PATH}/peer-key
        rm -rf ${INSTALL_PATH}/wallet
        rm -rf ${INSTALL_PATH}/main-light-consensus
        sed -ri 's/\"address": "(.*)",/"address": "'"${ADDRESS}"'",/' ${INSTALL_PATH}/sushipool.conf
        echo -e "${GREEN}Address has been set to ${ADDRESS}${NC}"
    fi
    if [[ $2 = "threads" ]]; then
        THREADS=$3
        if ! [[ "$THREADS" =~ ^[0-9]+$ ]]
        then
            echo -e "${RED}Invalid thread number!"
        fi
        sed -ri 's/\"threads": (.*),/"threads": '"${THREADS}"',/' ${INSTALL_PATH}/sushipool.conf
        echo -e "${GREEN}Threads has been set to ${3} ${NC}"
    fi
    if [[ $2 = "name" ]]; then
        NAME=${@:3}
        sed -ri 's/\"name": "(.*)",/"name": "'"${NAME}"'",/' ${INSTALL_PATH}/sushipool.conf
        echo -e "${GREEN}Miner name has been changed to ${NAME}${NC}"
    fi
    sushipool restart
fi
