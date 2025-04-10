#!/bin/sh
fileinstlocal=nfqws_install.sh
fileupdateLocal=nfqws_update.sh
fileupdate=https://raw.githubusercontent.com/Tornado6896/nfqws-updater/refs/heads/main/nfqws_install.sh
fileinst=https://raw.githubusercontent.com/Tornado6896/nfqws-updater/refs/heads/main/nfqws_update.sh
fileDir="/opt/usr/bin/"

wget "$fileupdate" -P "$fileDir"
wget "$fileinst" -P "$fileDir"
chmod +x "$fileDir""$fileinstlocal"
chmod +x "$fileDir""$fileupdateLocal"

nfqws_install.sh
