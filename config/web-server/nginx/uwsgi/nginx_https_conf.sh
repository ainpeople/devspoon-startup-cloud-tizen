#!/bin/bash

account=$1
domain=$2
portnumber=$3
appname=$4
service_port=$5

sed 's/account/'$account'/' sample_nginx_https.conf > $account'1'.temp
sed 's/domain/'$domain'/g' $account'1'.temp > $account'2'.temp
sed 's/portnumber;/'$portnumber';/' $account'2'.temp > $account'3'.temp
sed 's/appname/'$appname'/' $account'3'.temp > $account'4'.temp
sed 's/service_port/'$service_port'/' $account'4'.temp > ./pool.d/$account'_uwsgi_https_ng'.conf 

rm *.temp


while :
do 
    echo -n "Enter the service web root >"
    read webroot
    echo  "Entered service web root: $webroot"
    if [[ "$webroot" != "" ]]; then
        break
    fi
done 

while :
do 
    echo -n "Enter the service portnumber >"
    read portnumber
    echo  "Entered service portnumber: $portnumber"
    if [[ "$portnumber" != "" ]]; then
        break
    fi
done 

while :
do 
    echo -n "Enter the service domain >"
    read domain
    echo  "Entered service domain: $domain"
    if [[ "$domain" != "" ]]; then
        break
    fi
done 

while :
do 
    echo -n "Enter the app name >"
    read appname
    echo  "Entered app name: $appname"
    if [[ "$appname" != "" ]]; then
        break
    fi
done 

echo "Enter the serviceport"
echo -n "if you push enter with none, there are no port number >"
read serviceport
echo  "Entered proxy port: $serviceport"

while :
do 
    echo -n "Enter the file name >"
    read filename
    echo  "Entered file name: $filename"
    if [[ "$filename" != "" ]]; then
        break
    fi
done 

sed 's/webroot/'$webroot'/g' sample_nginx_https.conf > $filename'1'.temp
sed 's/domain/'$domain'/g' $filename'1'.temp > $filename'2'.temp
sed 's/portnumber/'$portnumber'/g' $filename'2'.temp > $filename'3'.temp
sed 's/appname/'$appname'/g' $filename'3'.temp > $filename'4'.temp
if [[ "$serviceport" == "" ]]; then
    sed 's/:serviceport/''/g' $filename'4'.temp > $filename'5'.temp
else
    sed 's/serviceport/'$serviceport'/g' $filename'4'.temp > $filename'5'.temp
fi
sed 's/filename/'$filename'/g' $filename'5'.temp > ./conf.d/$filename'_uwsgi_https_ng'.conf 

rm *.temp

