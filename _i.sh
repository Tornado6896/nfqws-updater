#!/bin/sh
opkg install tar
fileinstlocal=nfqws_install.sh
fileupdateLocal=nfqws_update.sh
curl -s -L https://github.com/Tornado6896/nfqws-updater/raw/refs/heads/main/updater.tar --output updater.tar && tar -xvf updater.tar -C /opt/usr/bin --overwrite > /dev/null && rm updater.tar
chmod +x "$fileDir""$fileinstlocal"
chmod +x "$fileDir""$fileupdateLocal"
nfqws_install.sh
