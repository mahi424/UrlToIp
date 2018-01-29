[ -x "$(which ${DIALOG%% *})" ] || DIALOG=dialog 

# Greeting page
$DIALOG --infobox "\n\n\n\n\n\n\n\n\n------------------Welcome To UrlToIp-------------------"  20 60
sleep 1


# input page for url
MYVAR=$($DIALOG --inputbox "ENTER THE URL (ctrl+shift+v)"  20 60  2>&1 >/dev/tty)
Temp=$MYVAR

# input page for domain
domain=$($DIALOG --inputbox "Enter the Domain of URL (Ex. .net, .com, .in etc.)"  20 60  2>&1 >/dev/tty)


# Here magic happens ;)
NAME=${MYVAR%$domain*} #retain string before domain name
NAME=${NAME##*//}  #cut the protocol (https, http etc.) it prevent issues during ping
NAME=$NAME$domain #concatenate the domain name

#ping the website, extract the ip address by pattern matching and assign to url
url="$(ping -c1 -n $NAME | head -n1 | sed "s/.*(\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\)).*/\1/g")"
# echo $url
new=${MYVAR/$NAME/$url} #replace the website name with its ip
# echo $new
new2=${new/"https://"/""} #concatenate the protocol


#the progress bar
dialog --gauge "Filling the tank"  20 60 0 < <(
    for i in {1..100};do
        printf "XXX\n%d\n%(%a %b %T)T progress: %d\nXXX\n" $i -1 $i
        sleep .033
    done
) 

# The Result dsiplay window

$DIALOG --infobox  "Your Result Is:\n\n$new2\n"   20 60 
echo

#print the result to command line if needed.
echo $new2
echo

# Direct command to open proccessed url in browser


google-chrome $new2
# firefox $new2

