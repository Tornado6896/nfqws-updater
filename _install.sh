#!/bin/sh

fileupdate=https://github.com/Tornado6896/nfqws-updater/blob/main/nfqws_update.sh
fileinst=https://github.com/Tornado6896/nfqws-updater/blob/main/nfqws_install.sh
fileDir="/opt/usr/bin/"
curl -O "$fileupdate"  -P "$fileDir" 
curl -O "$fileinst"  -P "$fileDir" 
chmod +X "$fileDir"&&"$fileinst"
 chmod +X "$fileDir"&&"$fileupdate"
