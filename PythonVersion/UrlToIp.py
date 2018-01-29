from easygui import *
import socket
import string
import webbrowser
# author mahi
title = "UrlToIp"
msg = "Enter The Url You Want To Process"
url = enterbox(msg, title)
spltAr = url.split("://");
i = (0,1)[len(spltAr)>1];
temp = spltAr[i].lower();
base = spltAr[i].split("?")[0].split('/')[0].split(':')[0].lower();
ip=socket.gethostbyname(base)
res=string.replace(temp,base,ip)
# Uncomment below to get the output in message box
# msgbox(new)

res="http://"+res
print res
webbrowser.open(res)