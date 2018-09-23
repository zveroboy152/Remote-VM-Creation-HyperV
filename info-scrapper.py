#Importing Modules
import socket
import random
import time
import datetime

#Grabs and stores data
import platform
machine = platform.machine()
ver = platform.version()
plat = platform.platform()
uname = platform.uname()
sys = platform.system()
proc = platform.processor()
date = datetime.datetime.today().strftime('%Y-%m-%d')

print (machine)
print (ver)
print (plat)
print (uname)
print (sys)
print (proc)
print (date)

text_file = open("Output"+plat+date+".txt", "w",)

text_file.write("info: \n"+machine+ver+plat+sys+proc+date)

text_file.close() 
