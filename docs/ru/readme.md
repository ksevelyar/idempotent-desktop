# Idempotent Desktop

![Build Status](https://github.com/ksevelyar/idempotent-desktop/workflows/build/badge.svg)

![screen](https://i.imgur.com/fWKORz4.png)
![screen](https://i.imgur.com/fhAtYZY.png)
![tomb](/images/tomb.png)

## [Документы](https://idempotent-desktop.netlify.app/)

Это хранилище —  просто набор [модулей](https://github.com/ksevelyar/idempotent-desktop/tree/mast..) NixOS, поэтому вы можете выбрать или переопределить что угодно.

[Остальные экраны](https://idempotent-desktop.netlify.app/screenshots.html).

## Характеристики

> Идемпотентность —  это свойство определенных операций в математике и информатике, благодаря которому их можно применять несколько раз без изменения результата за пределами исходного приложения.

### Agnostic DE without actual DE

- `xmonad`, `polybar`, `rofi`, `dunst`, `tmux`, `lxqt-policykit` и друзья
- Оптимизирован как для сенсорного ввода, так и для мышки
- Единый взгляд для gtk и qt с темой `ant-dracula`
- Эффективное использование ресурсов, требуется **меньше чем 500MB RAM** для загрузки графического интерфейса пользователя
- Установите систему со всеми вашими предпочтениями, используя три команды
- Документы доступны на [docs.lcl](http://docs.lcl) или при нажатии `win+h`

### Подходит для разработчиков и любителей DIY

- `elixir`, `node`, `rust` среды nix-shell
- `mongodb`, `postgresql`
- `docker`

- `arduino-ide`, `esptool.py`, `fritzing`
- `openscad`, `prusa-slicer`

### Инструменты CLI

- `fish`, `alacritty` w
- `fd`, `rg`, `fzf`, `delta`, `bat`
- `jq`
- `hunter`, `ncdu`, `zoxide`
- `tealdeer`
- `ddgr`, `googler`
- `imv`, `mpv`, `viu`, `moc`

### NixOS

- Опишите вашу систему перед установкой с помощью текстовых файлов и поместите их в git 
- Автоматическое резервное копирование после каждой пересборки
- Тестируйте хосты с помощью Cachix и [CI](https://github.com/ksevelyar/idempotent-desktop/blob/master/.github/workflows/build.yml)

### Безопасность 

- Используйте мастер пароль с `gopass` и интегрируйте его в [браузер](https://addons.mozilla.org/en-US/firefox/addon/browserpass-ce/)
- Храните свои секреты в `tomb`
- Смотрите информацию о соединениях `sshd` и `x11vnc` в `polybar`

### Анонимность

- Пакет браузера Tor и `onionshare`
- Tor как socks5 прокси для Telegram Desktop and Firefox.
- `openvpn` с `update-resolv-conf` (протестировано на [protonvpn.com](https://protonvpn.com))
- `wireguard`, `i2p`

### Проприетарный набор

Steam, Spotify, Slack, Upwork и другие, если они вам нужны.

### Игры

`games.nix` включает в себя opendune, dwarf-fortress, rogue, nethack, stepmania, wesnoth and wine

### Кастомизируемый Live Usb 💾

- [Собери](https://idempotent-desktop.netlify.app/live-usb.html)
- [Или скачай](https://drive.google.com/file/d/1XBa1LUK32A_DbMBge44co_AFfg44Ngqo/view?usp=sharing)

## Быстрая установка

Загрузиться с live-usb. Вы можете подготовить диски с `gparted` (Нажмите `Win` чтобы открыть меню запуска программ).

### Интернет

Требуется подключение к интернету.

Вы можете подключиться к wi-fi с помощью `nmtui` с терминала (`Win+Enter` для открытия терминала)

### Смонтировать диски (EFI)

```fish
mount /dev/disk/by-label/nixos /mnt
mount /dev/disk/by-label/boot  /mnt/boot

```

### Клонировать репозиторий в /mnt/etc/nixos

```fish
sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos
```

### Свяжите свою машину

```fish
cd /mnt/etc/nixos
ln -s hosts/hk47.nix configuration.nix
```

### Установить

```fish
sudo nixos-install
```

NixOS запросит пароль root при успешной установке

### Завершить создание пользователя

Установите пароль и правильные права для пользователя в /etc/nixos:

```fish
sudo passwd username
sudo chown 1000:1000 /mnt/etc/nixos
```

Теперь вы можете перезагрузить систему с помощью команды `reboot`.

## Более подробная установка с новым поколением хостов и пользователей


Физические машины находятся в `hosts`; пользователи в `users`. Вам нужно привязать ваш хост к configuration.nix и пересобрать систему.

Пример свежей установки с `live-usb`:

### Клонировать репозиторий

`sudo git clone https://github.com/ksevelyar/idempotent-desktop.git /mnt/etc/nixos`

### Создать нового пользователя

`nvim /mnt/etc/nixos/users/new-user.nix`

Можете использовать [ksevelyar.nix](https://github.com/ksevelyar/idempotent-desktop/blob/master/users/ksevelyar.nix) как пример.

### Генерация конфигов и объединение их с новым хостом

```sh
sudo nixos-generate-config --root /mnt
bat /mnt/etc/nixos/*.nix
sudo mv /mnt/etc/nixos{,.bak}

nvim /mnt/etc/nixos/hosts/new-host.nix

```

Можете использовать [hk47.nix](https://github.com/ksevelyar/idempotent-desktop/blob/master/hosts/hk47.nix) как пример.

### Установка nixos

```sh
sudo nixos-install
```

В конце вы должны увидеть запрос на ввод пароля root.

### Скрипты и алиасы помогут сэкономить время 

- [scripts.nix](https://github.com/ksevelyar/idempotent-desktop/blob/mast../sys/scripts.nix)
- [aliases.nix](https://github.com/ksevelyar/idempotent-desktop/blob/mast../sys/aliases.nix)

## Todo 🍒

- [ ] Live Usb with persistence layer
- [ ] Write docs
  - [ ] Русская документация
  - [ ] Add animated svgs to docs
  - [x] Find dark theme for vuepress
- [ ] Declarative Node packages
- [ ] Declarative secrets
- [ ] Pack [Neovide](https://github.com/Kethku/neovide)
- [ ] semantic versioning
