# nfqws-updater

> [!ВНИМАНИЕ]
> Данный материал подготовлен в научно-технических целях.
> Использование предоставленных материалов в целях отличных от ознакомления может являться нарушением действующего законодательства.
> Автор не несет ответственности за неправомерное использование данного материала.

> [!ОСТОРОЖНО]
> **Вы пользуетесь этой инструкцией на свой страх и риск!**
> 
> Автор не несёт ответственности за порчу оборудования и программного обеспечения.
> Подразумевается, что вы понимаете, что вы делаете.
> 
Написано для роутеров Keenetic/Netcraze с установленным entware.
### Работоспособность на OpenWRT не проверена

### Что это?

`nfqws-updater`- небольшой скрипт для автоматизации установки NFQWS.
## Возможности скрипта и описание команд:
 - Главаное меню -menu;
 - Автоматическая установка nfqws(устанвока всех пакетов, userlist, создание политики, прописывание DOT/DOH, добваление задачи на проверку обновлений в cron);
 - Полная установка службы nfqws (Вместе с зависимостями) -install-nfqws-full; 
 - Установка службы nfqws -install-nfqws;
 - Обновление службы nfqws -update-nfqws;
 - Перезапуск службы nfqws -restart-nfqws; 
 - Добавление DNS записей -add-dns;
 - Добавление политики nfqws -add-policy; 
 - Полное удаление nfqws (Вместе с зависимостями) -remove-nfqws;
 - Удаление DNS записей -del-dns;
 - Удаление политики nfqws -del-policy;
 - Перезапуск службы cron -restart-cron;
 - Обновление userlist -update-userlist;
 - Выбор времени проверки обновлений nfqws и userlist -time-update;
 - Редактирование данных telegram токена и группы -token;
  
        
  <p align="left">
  <a href="https://github.com/Tornado6896/nfqws-updater/blob/main/comand.png" target="_blank" rel="noopener noreferrer">
    <picture>
      <source media="https://github.com/Tornado6896/nfqws-updater/blob/main/comand.png">
      <img src="https://github.com/Tornado6896/nfqws-updater/blob/main/comand.png">
    </picture>
  </a>
</p>

### Отправка уведолений в Telegram, возможна при наличии бота и группы.

  <p align="left">
  <a href="https://github.com/Tornado6896/nfqws-updater/blob/main/tg.png" target="_blank" rel="noopener noreferrer">
    <picture>
      <source media="https://github.com/Tornado6896/nfqws-updater/blob/main/tg.png">
      <img src="https://github.com/Tornado6896/nfqws-updater/blob/main/tg.png">
    </picture>
  </a>
</p>


### Установка на Keenetic/Netcraze с Entware

>  Выполнять от пользователя root на уже установленную Entware

```bash
curl -sOfL https://github.com/Tornado6896/nfqws-updater/raw/refs/heads/main/_i.sh && chmod +x ./_i.sh && ./_i.sh
```


## Для вызова констестного меню можно восользоваться командой:

```bash
nfqws_updater
```
<p align="left">
  <a href="https://github.com/Tornado6896/nfqws-updater/blob/main/menu.png" target="_blank" rel="noopener noreferrer">
    <picture>
      <source media="https://github.com/Tornado6896/nfqws-updater/blob/main/menu.png">
      <img src="https://github.com/Tornado6896/nfqws-updater/blob/main/menu.png">
    </picture>
  </a>
</p>
