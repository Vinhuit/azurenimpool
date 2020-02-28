import pyautogui
import os ,time,sys
import requests, json
from threading import Thread

def getDevice():
	json_address = 'http://jsonserver01.herokuapp.com/rerunaccount'
	data = None
	listDev=[]
	while data is None:
		try:
			print("try get offline stream")
			data = requests.get(json_address).json()
			return data
		except:
			 pass
	if len(data)>0:
		for i in data:
			if (i["isAvailable"] == "True") and (i["isStart"] == "False"):
				userName = i["userName"]
				domain = i["domain"]
				listDev.append(domain,userName)
				break
		return listDev

num=sys.argv[1]
mylist = getDevice()
profile = mylist[0]
domain = mylist[1]
print (sys.argv)
p="a"+str(profile)
os.system("google-chrome-stable --profile-directory={0} --window-size=1280,960 --window-position=0,0 &".format(p))

for i in range(100):
	if i==50:
		domain="ginz.xyz"
		num=1
	if i==100:
		domain="ginz01.xyz"
		num=1
	if i%10==0:
		profile=int(profile)+1
		p="a"+str(profile)
		os.system("google-chrome-stable	 --profile-directory={0} --window-size=1280,960 --window-position=0,0 &".format(p))
	else:
		time.sleep(2)
		os.system('google-chrome-stable "https://accounts.google.com/AddSession?hl=en&continue=https://colab.research.google.com" &')
	time.sleep(6)
	print(i)
	# pyautogui.click(x=1243, y=264)
	# time.sleep(2)
	# pyautogui.click(x=1267, y=126)
	# time.sleep(2)
	# pyautogui.click(x=1038, y=612)
	# time.sleep(2)
	# pyautogui.click(x=1027, y=284)
	# time.sleep(2)
	# pyautogui.press('end')
	# time.sleep(2)
	# pyautogui.click(x=610, y=527)
	# time.sleep(4)

	pyautogui.click(x=558, y=490)
	time.sleep(1)
	if int(num)>9:
		mail="minh"+str(num)+"@"+domain
	else:
		mail="minh"+"0"+str(num)+"@"+domain
	pyautogui.typewrite(mail)
	time.sleep(1)
	pyautogui.press('enter')
	time.sleep(1)
	pyautogui.typewrite("anhvinh12")
	pyautogui.press('enter')
	time.sleep(1)
	time.sleep(1)
	pyautogui.click(x=1053, y=274)
	time.sleep(1)
	pyautogui.press('end')
	time.sleep(1)
	pyautogui.click(x=638, y=652)
	pyautogui.click(x=633, y=628)
	time.sleep(3)

	pyautogui.click(x=349, y=436)
	time.sleep(2)
	pyautogui.click(x=59, y=167)
	time.sleep(1)
	pyautogui.click(x=59, y=167)
	time.sleep(1)
	pyautogui.hotkey('ctrl', 'v')
	time.sleep(1)
	pyautogui.click(x=273, y=140)
	time.sleep(1)
	pyautogui.click(x=339, y=434)
	time.sleep(1)
	pyautogui.click(x=598, y=559)
	time.sleep(1)
	pyautogui.press('down')
	time.sleep(1)
	pyautogui.press('enter')
	time.sleep(1)
	pyautogui.click(x=822, y=655)
	time.sleep(1)
	pyautogui.hotkey('ctrl', 'f9')
	num=int(num)+1

time.sleep(5600)
os.system("pkill -f chrome")
os.system("rm -rf .config/google-chrome/a*")
os.system("rm -rf ~/.config/google-chrome/Singleton*")
os.system("python3 pygui.py 1 1 ginz.store")
