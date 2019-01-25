from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import Select
from selenium.webdriver.common.action_chains import ActionChains
import time
import sys
import os
import requests
from requests.exceptions import ConnectionError
import subprocess
import threading

def RefreshAccount(pool):
		print("Start Rerun "+pool)
		reqRm = 'http://'+pool+'.herokuapp.com/custom?link=pkill+bash%3Bpkill+miner&key=&lach='
		try:
			f =  requests.get(reqRm,timeout=4,verify=False)
			print("Done "+pool)
		except:
			pass
		#print("Start Sent Requet "+pool)
		#reqStart = 'http://'+pool+'.herokuapp.com/custom?link=mkdir+miner%3Bcd+miner%3Bwget+https%3A%2F%2Fraw.githubusercontent.com%2FVinhuit%2Fazurenimpool%2Fmaster%2Fazure_script%2Frun2.sh%3Bchmod+u%2Bx+run2.sh%3B+.%2Frun2.sh+'+pool+'&key=&lach='
		#try:
			#f =  requests.get(reqStart,timeout=2,verify=False)
		#except:
			#pass
def MultiRequest(urls):
	threads = []
	for line in urls:
		process = Thread(target=RefreshAccount, args=(line.rstrip(),))
		process.start()
		threads.append(process)
		for process in threads:
   			process.join()
def Compare():
	with open('offline.txt', 'r') as file1:
		with open('online.txt', 'r') as file2:
			same = set(file1).symmetric_difference(file2)

	same.discard('\n')
	list(set(same))
	with open('accounts.txt', 'w') as file_out:
		for line in sorted(same):
			file_out.write(line)
			
def UptimeroboSelenium(headless,mail):
	startNumber = input('Number start: ')
	chrome_options = Options()
	if(headless=='yes'):
		chrome_options.add_argument("--headless")

	driver = webdriver.Chrome("./chromedriver.exe",chrome_options=chrome_options)
	driver.implicitly_wait(10)
	driver.get("https://uptimerobot.com/login")

	elem = driver.find_element_by_xpath("//*[@id=\"userEmail\"]")
	elem.clear()
	elem.send_keys(mail)

	elem = driver.find_element_by_xpath("//*[@id=\"userPassword\"]")
	elem.send_keys("anhvinh12")
	elem.send_keys(Keys.RETURN)

	elem = driver.find_element_by_xpath("//*[@id=\"main-container\"]/div[1]/div/div[1]/div/div[1]/a")
	elem.click()
	num=int(startNumber)
	for i in range(0,50):
		try:
			elem = driver.find_element_by_xpath("//*[@id=\"s2id_newMonitorType\"]/a")
			time.sleep(1)
			elem.click()
			time.sleep(1)
			elem.send_keys(Keys.ARROW_DOWN)
			elem.send_keys(Keys.RETURN)
			time.sleep(2)
			elem = driver.find_element_by_xpath("//*[@id=\"newHTTPMonitorFriendlyName\"]")
			name="mtpool"+str((num+i))
			print(name)
			elem.send_keys(name)
			elem = driver.find_element_by_xpath("//*[@id=\"newHTTPMonitorURL\"]")
			url="http://"+name+".herokuapp.com"
			elem.clear()
			elem.send_keys(url)
			elem = driver.find_element_by_xpath("//*[@id=\"newMonitorForm\"]/div[2]/button[2]")
			elem.click()
			time.sleep(1)
			elem.click()
			time.sleep(2)
		except:
			pass
			print("fail")
			continue
	driver.close()
def CreatePool():
	subprocess.call([r'CreatePool.cmd'])
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
def sort_by_name(d):
    '''a helper function for sorting'''
    return d['name']
def SimpleMonitor():
	status = 'online'
	json_address = json_address_for_sushi()
	data = requests.get(json_address).json()
	devices = data['devices']
	devices=sorted(devices,key=sort_by_name)
	open('offline.txt', 'w').close()
	open('online.txt', 'w').close()
	for device in devices:
		miner_name = device['name']
		miner_status = device['device_status']
		
		if miner_status != status:
			open('offline.txt', 'a').write(miner_name+"\n")
		else:
			open('online.txt', 'a').write(miner_name+"\n")
def CreateHeroku():
	while(1):
		chrome_options = Options()
		num=4
		driver = webdriver.Chrome("./chromedriver.exe",chrome_options=chrome_options)
		driver.implicitly_wait(10)
		driver.get("https://signup.heroku.com/")
		elem = driver.find_element_by_xpath("//*[@id=\"first_name\"]")
		elem.send_keys("trung")
		elem = driver.find_element_by_xpath("//*[@id=\"last_name\"]")
		elem.send_keys("tran")
		mail= "trungtran" + str(num) + "@4petstores.online"
		num=num+1
		elem = driver.find_element_by_xpath("//*[@id=\"email\"]")
		elem.send_keys(mail)
		elem = driver.find_element_by_xpath("//*[@id=\"company\"]")
		elem.send_keys("ctz")
		elem = driver.find_element_by_xpath("//*[@id=\"role\"]")
		elem.click()
		elem.send_keys(Keys.ARROW_DOWN)
		elem.send_keys(Keys.RETURN)
		elem = driver.find_element_by_xpath("//*[@id=\"main_programming_language\"]")
		elem.click()
		elem.send_keys(Keys.ARROW_DOWN)
		elem.send_keys(Keys.ARROW_DOWN)
		elem.send_keys(Keys.ARROW_DOWN)
		elem.send_keys(Keys.ARROW_DOWN)
		elem.send_keys(Keys.RETURN)
		elem = driver.find_element_by_xpath("//*[@id=\"recaptcha-anchor\"]")
		elem.click()
		time.sleep(30)
print("""
1 - Rerun Device
2 - Start Add Ping Heroku
3 - Start Create Device Heroku
4 - Start Create Account Heroku
5 - Get Status Device
"""
)
def main(n=1):
	#n = int(input('Please enter the number: '))
	if n==1:
		#os.system("notepad accounts.txt")
		f = open("accounts.txt", "rt")
		for pool in f:
			print("Start rerun "+pool)
			pool =pool.rstrip()
			t=threading.Thread(target=RefreshAccount,args=(pool,))
			t.daemon = True
			t.start()
		#MultiRequest(f)
		#RefreshAccount(f)
	elif n==2:
			print("Start Add Ping Heroku")
			UptimeroboSelenium(sys.argv[1],sys.argv[2])
	elif n==3:
		print("Start Create Pool Heroku")
		CreatePool()
	elif n==4:
		print("Start Create Account Heroku")
		CreateHeroku()
	else:
		SimpleMonitor()
		Compare()
		#os.system("notepad accounts.txt")	
main(5)
main(1)