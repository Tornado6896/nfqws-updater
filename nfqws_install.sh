#!/bin/sh

#Переменные
RoutID="$(echo $(hostname) | tr '[:lower:]' '[:upper:]')"
urlList="https://raw.githubusercontent.com/Tornado6896/nfqws-updater/refs/heads/main/user.lst"
confDirNfqws="/opt/etc/nfqws"
listLocal="$confDirNfqws/user.list"

# Переменные не обязательны. Если пустые, отправка сообщения не осуществляется.

echo Enter your tgToken:
read tgToken
echo -e "Ваш токен: $tgToken"
echo Enter your tgChatId:
read tgChatId
echo -e "Ваш чат: $tgChatId"

initd_file="/opt/usr/bin/nfqws_var"
script_content='#!/bin/sh 
tgToken="'${tgToken}'"
tgChatId="'${tgChatId}'"
'
echo "Файл nfqws_var создан"	
        echo -e "${script_content}" > "${initd_file}" 
        chmod +x "${initd_file}"
		
# Функции
function sendTelegram {
  local tgUrl="https://api.telegram.org/bot$tgToken/sendMessage"
  local tgTimeout="10"
  local tgText="$@"
  local tgCmdArgs="parse_mode=HTML&chat_id=$tgChatId&disable_web_page_preview=1&text=$tgText"
  tgCmd=$(curl --max-time $tgTimeout -d "$tgCmdArgs" $tgUrl -s)
  if [ $? -gt 0 ]; then echo "Ошибка отправки Telegram"; else echo "Отправка сообщения Telegram Успешно!"; fi
}
function InstallNFQWS {
echo "Установка NFQWS"
opkg update
opkg install ca-certificates wget-ssl
opkg remove wget-nossl
opkg install wget-ssl
mkdir -p /opt/etc/opkg
echo "src/gz nfqws-keenetic https://anonym-tsk.github.io/nfqws-keenetic/all" > /opt/etc/opkg/nfqws-keenetic.conf
opkg update
opkg install nfqws-keenetic
opkg install nfqws-keenetic-web
VerWeb="$(opkg info nfqws-keenetic-web | grep "Version")"
Ver="$(opkg info nfqws-keenetic | grep "Version:")"
echo "$RoutID: Служба Nfqws установлена $Ver. Служба Nfqws-web установлена $VerWeb";
sendTelegram "$RoutID: Служба Nfqws установлена $Ver. Служба Nfqws-web установлена $VerWeb";
}
function InstallUserList {
echo "Установка UserList"

  local tsRemote=$(curl -sIkL --connect-timeout 5 "$urlList" | grep -i 'Content-Length' | tail -n 1 | sed 's|Content-Length: ||g')
  local tslocal=$(wc -c /opt/etc/nfqws/user.list | awk '{print $1}')
  if [ "$tslocal" -ne "$tsRemote" ]; then
    local count1="$(wc /opt/etc/nfqws/user.list | awk '{print $1}')"
    rm -f "$listLocal"
	curl --connect-timeout 10 -fkSL# "$urlList" > "$listLocal"
  
    if [ -n "$tgToken" -a -n "$tgChatId" ]; then
	   count2="$(wc /opt/etc/nfqws/user.list | awk '{print $1}')"
	   echo "$count2"
	   echo "$count1"
	   count3=$((count2 - count1))
	  echo "$RoutID: user.list успешно установлен, добавлено новых записей $count3";
	  sendTelegram "$RoutID: user.list успешно установлен, добавлено новых записей $count3";
    chown nobody:nobody "$listLocal"
    chmod 644 "$listLocal"
	sleep 10s 
    /opt/etc/init.d/S51nfqws restart
	echo "$RoutID: Служба Nfqws перезапущена";
	sendTelegram "$RoutID: Служба Nfqws перезапущена";
	fi
  fi
}
# Функция для регистрации инициализационного скрипта cron
function registerCron {
    echo "Проверка наличия пакета cron"
	# Проверка наличия пакета cron
    if opkg list-installed | grep -q cron; then
        return
    fi

    # Определение переменных
    local initd_file="/opt/etc/init.d/S05crond"
    local s05crond_filename="${current_datetime}_S05crond"
    local required_script_version="0.4"

    # Проверка наличия файла S05crond
    if [ -e "${initd_file}" ]; then
        # Получение текущей версии скрипта
        local script_version=$(grep 'version=' "${initd_file}" | grep -o '[0-9.]\+')

        # Проверка версии скрипта
        if [ "${script_version}" != "${required_script_version}" ]; then
            # Определение пути для резервной копии
            local backup_path="/opt/etc/init.d/${s05crond_filename}"

            # Перемещение файла в каталог резервных копий с новым именем
            mv "${initd_file}" "${backup_path}"
            echo -e "  Ваш файл «${green}S05crond${reset}» перемещен в каталог резервных копий «${yellow}${backup_path}${reset}»"
        fi
    fi

    # Содержимое скрипта
    local script_content='#!/bin/sh
### Начало информации о службе
# Краткое описание: Запуск / Остановка Cron
# version="0.4"  # Версия скрипта
### Конец информации о службе

green="\033[32m"
red="\033[31m"
yellow="\033[33m"
reset="\033[0m" 

cron_initd="/opt/sbin/crond"

# Функция для проверки статуса cron
cron_status() {
    if ps | grep -v grep | grep -q "$cron_initd"; then
        return 0 # Процесс существует и работает
    else
        return 1 # Процесс не существует
    fi
}

# Функция для запуска cron
start() {
    if cron_status; then
        echo -e "  Cron ${yellow}уже запущен${reset}"
    else
        $cron_initd -L /dev/null
        echo -e "  Cron ${green}запущен${reset}"
    fi
}

# Функция для остановки cron
stop() {
    if cron_status; then
        killall -9 "crond"
        echo -e "  Cron ${yellow}остановлен${reset}"
    else
        echo -e "  Cron ${red}не запущен${reset}"
    fi
}

# Функция для перезапуска cron
restart() {
    stop > /dev/null 2>&1
    start > /dev/null 2>&1
    echo -e "  Cron ${green}перезапущен${reset}"
}

# Обработка аргументов командной строки
case "$1" in
    start)
        start;;
    stop)
        stop;;
    restart)
        restart;;
    status)
        if cron_status; then
            echo -e "  Cron ${green}запущен${reset}"
        else
            echo -e "  Cron ${red}не запущен${reset}"
        fi;;
    *)
        echo -e "  Команды: ${green}start${reset} | ${red}stop${reset} | ${yellow}restart${reset} | status";;
esac

exit 0'
    
    # Создание или замена файла, если версия скрипта не соответствует требуемой версии 
    if [ "${script_version}" != "${required_script_version}" ]; then
        echo "Файл S05crond создан"	
        echo -e "${script_content}" > "${initd_file}" 
        chmod +x "${initd_file}" 
		
    fi 
}
function crontabs {
echo "Проверка наличия файла crontab"
local initd_crontab="/opt/var/spool/cron/crontabs/root"
if [ ! -e "${initd_crontab}" ]; then
echo "Файл crontab не найден"
mkdir -p /opt/var/spool/cron/crontabs
touch /opt/var/spool/cron/crontabs/root
chmod +x "${initd_crontab}"
echo "Файл crontabs создан"	;
else
echo "Файл crontab уже существет";
fi
}
 function choose_cron_time {
        task_var="chose_${task}_cron_select"
        time_var="chose_${task}_cron_time"
		task="taskuserlist"
        local initd_crontab="/opt/var/spool/cron/crontabs/root"
		
        if [ "$(eval echo \${$task_var})" != true ]; then
            echo
            if [ "$task" = "taskuserlist" ]; then
                echo -e "  Время автоматического обновления для ${yellow}всех${reset} задач:"
            else
                echo -e "  Время автоматического обновления ${yellow}$task${reset}:"
            fi
            echo
            echo "  Выберите день"
            echo "     0. Отмена"
            echo "     1. Понедельник"
            echo "     2. Вторник"
            echo "     3. Среда"
            echo "     4. Четверг"
            echo "     5. Пятница"
            echo "     6. Суббота"
            echo "     7. Воскресенье"
            echo "     8. Ежедневно"
            echo

            local day_choice
            while true; do
                read -p "  Ваш выбор: " day_choice
                if [[ "$day_choice" =~ ^[0-8]$ ]]; then
                    break
                else
                    echo -e "  ${red}Некорректный номер действия.${reset} Пожалуйста, выберите снова"
                fi
            done

            if [ "$day_choice" -eq 0 ]; then
                echo -e "  Включение автоматического обновления ${yellow}$task${reset} отменено."
            else
                if [ "$day_choice" -eq 8 ]; then
                    echo
                    read -p "  Выберите час (0-23): " hour
                    while [[ ! "$hour" =~ ^[0-9]+$ || "$hour" -lt 0 || "$hour" -gt 23 ]]; do
                        echo -e "  ${red}Некорректный час.${reset} Пожалуйста, попробуйте снова"
                        read -p "  Введите значение от 0 до 23: " hour
                    done

                    read -p "  Выберите минуту (0-59): " minute
                    while [[ ! "$minute" =~ ^[0-9]+$ || "$minute" -lt 0 || "$minute" -gt 59 ]]; do
                        echo -e "  ${red}Некорректные минуты.${reset} Пожалуйста, попробуйте снова"
                        read -p "  Введите значение от 0 до 59: " minute
                    done

                    cron_expression="$minute $hour * * *"
                    cron_display="$minute $hour * * *"
                else
                    echo
                    read -p "  Выберите час (0-23): " hour
                    while [[ ! "$hour" =~ ^[0-9]+$ || "$hour" -lt 0 || "$hour" -gt 23 ]]; do
                        echo -e "  ${red}Некорректный час.${reset} Пожалуйста, попробуйте снова"
                        read -p "  Введите значение от 0 до 23: " hour
                    done

                    read -p "  Выберите минуту (0-59): " minute
                    while [[ ! "$minute" =~ ^[0-9]+$ || "$minute" -lt 0 || "$minute" -gt 59 ]]; do
                        echo -e "  ${red}Некорректные минуты.${reset} Пожалуйста, попробуйте снова"
                        read -p "  Введите значение от 0 до 59: " minute
                    done

                    case "$day_choice" in
                        1) day_of_week="1" ;;
                        2) day_of_week="2" ;;
                        3) day_of_week="3" ;;
                        4) day_of_week="4" ;;
                        5) day_of_week="5" ;;
                        6) day_of_week="6" ;;
                        7) day_of_week="0" ;;
                    esac

                    cron_expression="$minute $hour * * $day_of_week"
                    cron_display="$minute $hour * * $day_of_week"
                fi

                formatted_hour=$(printf "%02d" "$hour")
                formatted_minute=$(printf "%02d" "$minute")

                day_name=""
                case "$day_choice" in
                    0) day_name="Отмена" ;;
                    1) day_name="Понедельник" ;;
                    2) day_name="Вторник" ;;
                    3) day_name="Среда" ;;
                    4) day_name="Четверг" ;;
                    5) day_name="Пятница" ;;
                    6) day_name="Суббота" ;;
                    7) day_name="Воскресенье" ;;
                    8) day_name="Ежедневно" ;;
                esac
                eval "${time_var}='$cron_expression'"
				echo -e "${cron_expression} /opt/usr/bin/nfqws_update" > "${initd_crontab}" 
				echo -e "  Время автоматического обновления ${yellow} NFQWS ${reset}: $day_name в $formatted_hour:$formatted_minute"
				/opt/etc/init.d/S05crond restart;
				echo "$RoutID: Служба Cron перезапущена";
	            sendTelegram "$RoutID: Время автоматического обновления NFQWS $day_name в $formatted_hour:$formatted_minute";
				fi
        fi
		
}
#Скрипт
InstallNFQWS; 
InstallUserList; 
registerCron;
crontabs;
choose_cron_time;

