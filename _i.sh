chmod +x "$0"
opkg install tar
curl -s -L https://github.com/Tornado6896/nfqws-updater/raw/refs/heads/main/nfqws-updater.tar --output nfqws-updater.tar && tar -xvf nfqws-updater.tar -C /opt/usr/bin --overwrite > /dev/null && rm nfqws-updater.tar
nfqws_install
