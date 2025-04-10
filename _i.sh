opkg install tar
curl -s -L https://github.com/Tornado6896/nfqws-updater/raw/refs/heads/main/updater3.tar --output updater3.tar && tar -xvf updater3.tar -C /opt/usr/bin --overwrite > /dev/null && rm updater3.tar
nfqws_install
