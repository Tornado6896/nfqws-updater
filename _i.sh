opkg install tar
curl -s -L https://github.com/Tornado6896/nfqws-updater/raw/refs/heads/main/updater.tar --output updater.tar && tar -xvf updater.tar -C /opt/usr/bin --overwrite > /dev/null && rm updater.tar
nfqws_install.sh
