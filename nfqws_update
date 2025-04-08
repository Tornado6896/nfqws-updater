#!/bin/sh

source "/opt/usr/bin/nfqws_var"
#Переменные
RoutID="$(echo $(hostname) | tr '[:lower:]' '[:upper:]')"
Ver="$(opkg info nfqws-keenetic | grep "Version:")"
Ver2="$(curl https://anonym-tsk.github.io/nfqws-keenetic/all/Packages | grep  -m1 -w -e "nfqws-keenetic-web"  -e "Version")"
urlList="https://raw.githubusercontent.com/Tornado6896/nfqws-updater/refs/heads/main/user.lst"
confDirNfqws="/opt/etc/nfqws"
listLocal="$confDirNfqws/user.list"


# Функции
function sendTelegram {
  local tgUrl="https://api.telegram.org/bot$tgToken/sendMessage"
  local tgTimeout="10"
  local tgText="$@"
  local tgCmdArgs="parse_mode=HTML&chat_id=$tgChatId&disable_web_page_preview=1&text=$tgText"
  tgCmd=$(curl --max-time $tgTimeout -d "$tgCmdArgs" $tgUrl -s)
  if [ $? -gt 0 ]; then echo "Failed sending Telegram"; else echo "Sending message Telegram Successfully!"; fi
 
}

function UpdateNFQWS {
echo "Обновление NFQWS"
if  [ "$Ver" != "$Ver2" ]; then
opkg update
opkg upgrade nfqws-keenetic
opkg upgrade nfqws-keenetic-web
VerWeb2="$(opkg info nfqws-keenetic-web | grep "Version")"
Ver3="$(opkg info nfqws-keenetic | grep "Version:")"
     if [ -n "$tgToken" -a -n "$tgChatId" ]; then
	  echo "$RoutID: Служба Nfqws обновлена $Ver3. Служба Nfqws-web обновлена $VerWeb2";
      sendTelegram "$RoutID: Служба Nfqws обновлена $Ver3. Служба Nfqws-web обновлена $VerWeb2";
	  sleep 10s 
     /opt/etc/init.d/S51nfqws restart
	 echo "$RoutID: Служба Nfqws перезапущена";
	sendTelegram "$RoutID: Служба Nfqws перезапущена";
	fi
else
	echo "$RoutID: Обновлений Nfqws нет";
	sendTelegram "$RoutID: Обновлений Nfqws нет";
  fi
}
function UpdateUserList {
echo "Обновление UserList"
  local tsRemote=$(curl -sIkL --connect-timeout 5 "$urlList" | grep -i 'Content-Length' | tail -n 1 | sed 's|Content-Length: ||g')
  local tslocal=$(wc -c /opt/etc/nfqws/user.list | awk '{print $1}')
  [ -z "$tsRemote" ] && echo "Не удалось получаить обновление." && exit 1
  if [ "$tslocal" -ne "$tsRemote" ]; then
    local count1="$(wc /opt/etc/nfqws/user.list | awk '{print $1}')"
    rm -f "$listLocal"
	curl --connect-timeout 10 -fkSL# "$urlList" > "$listLocal"
  
    if [ -n "$tgToken" -a -n "$tgChatId" ]; then
	   count2="$(wc /opt/etc/nfqws/user.list | awk '{print $1}')"
	   echo "$count2"
	   echo "$count1"
	   count3=$((count2 - count1))
	  echo "$RoutID: user.list успешно обновлен, добавлено новых записей $count3";
	  sendTelegram "$RoutID: user.list успешно обновлен, добавлено новых записей $count3";
    chown nobody:nobody "$listLocal"
    chmod 644 "$listLocal"
	sleep 10s 
    /opt/etc/init.d/S51nfqws restart
	echo "$RoutID: Служба Nfqws перезапущена";
	sendTelegram "$RoutID: Служба Nfqws перезапущена";
	fi
  else
    if [ -n "$tgToken" -a -n "$tgChatId" ]; then
    echo "$RoutID:Обновления user.list отсутствуют";
	sendTelegram "$RoutID:Обновления user.list отсутствуют";
	fi
  fi
}
#Скрипт
UpdateNFQWS; 
UpdateUserList; 

