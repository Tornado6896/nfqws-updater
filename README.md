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
## Возможности скрипта:
 - Автоматическая установка nfqws(устанвока всех пакетов, user.list, создание политики, прописывание DOT/DOH, добваление задачи на проверку обновлений в cron);
 - Полная установка nfqws;
 - Установка nfqws;
 - Обновление nfqws;
 - Перезапуск nfqws;
 - Добавление DNS записей;
 - Добавление политики nfqws;
 - Удаление nfqws;
 - Удаление DNS записей;
 - Удаление политики nfqws;
 - Перезапуск cron;
 - Обновление userlist;
 - Выбор времени проверки обновлений nfqws и userlist;
 - Редактирование данных telegram;
  
        
  <p align="left">
  <a href="https://github.com/Tornado6896/nfqws-updater/blob/main/nfqws_menu.png" target="_blank" rel="noopener noreferrer">
    <picture>
      <source media="https://github.com/Tornado6896/nfqws-updater/blob/main/nfqws_menu.png">
      <img src="https://github.com/Tornado6896/nfqws-updater/blob/main/nfqws_menu.png">
    </picture>
  </a>
</p>

### Отправка уведолений в telegram, возможна при наличии бота и группы.

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
  <a href="https://github.com/Tornado6896/nfqws-updater/blob/main/nfqws_help.png" target="_blank" rel="noopener noreferrer">
    <picture>
      <source media="https://github.com/Tornado6896/nfqws-updater/blob/main/nfqws_help.png">
      <img src="https://github.com/Tornado6896/nfqws-updater/blob/main/nfqws_help.png">
    </picture>
  </a>
</p>
