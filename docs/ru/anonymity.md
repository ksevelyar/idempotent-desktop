# Анонимность

> “Демократия требует конфиденциальности так же, как и свободы слова.” Аноним

## [I2P](https://geti2p.net/en/about/intro)

* Консоль роутера доступна через веб-браузер по адресу [localhost:7070](http://localhost:7070).
* http прокси `http://127.0.0.1:4444`
* http://identiguy.i2p/

## Используйте [Tor](https://github.com/ajvb/awesome-tor) в качестве socks5 прокси

### Firefox со [SwitchyOmega](https://addons.mozilla.org/en-US/firefox/addon/switchyomega/)

![tor](https://i.imgur.com/OeUgl6W.png)
![proxy](https://i.imgur.com/7PEcbNm.png)

💩 [Список сайтов, заблокированных в России](https://en.wikipedia.org/wiki/List_of_websites_blocked_in_Russia) 💩

### Telegram Desktop

![telegram-desktop](https://i.imgur.com/fJ82MBK.png)

## Tor Browser

![tor-browser](https://i.imgur.com/QnBy41v.png)

## Оберните любую программу в `torsocks`

```sh
torsocks curl ifconfig.me
```

## Блокировка рекламы и трекеров

[uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)

## DNS через TLS с kresd

[services.kresd](https://github.com/ksevelyar/idempotent-desktop/blob/42b8264d1b259c99f887be38224f3ae0a62448../services/net/firewall-desktop.nix#L4-L14)

## Используйте VPN, если вам нужна анонимность

`openvpn` предустановлен, вы можете попробовать бесплатный [ProtonVpn](https://protonvpn.com/).

## Shell

### Отсутствие записи команд в истории

Перед важными программами (pass and tomb kind of stuff) используйте пробел: ` pass`.

Таким образом вы даете команду своей оболочке не хранить это в истории.

### Удаление конфиденциальных команд из истории с нечетким соответствием

Можете удалить историю следующим образом:

```fish
history --delete --contains 'openvpn'

[1] sudo openvpn us-free-03.protonvpn.com.udp.ovpn
[2] sudo openvpn USA_freeopenvpn_udp.ovpn
[3] sudo openvpn us-free-02.protonvpn.com.udp.ovpn

Enter nothing to cancel the delete, or
Enter one or more of the entry IDs separated by a space, or
Enter "all" to delete all the matching entries.

Delete which entries? >
```
