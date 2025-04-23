cd /opt/sbin
cp curl -ss -L https://github.com/Tornado6896/nfqws-updater/raw/refs/heads/main/nfqws_updater /opt/sbin/nfqws_updater
chmod +x "$0"
nfqws_updater menu
