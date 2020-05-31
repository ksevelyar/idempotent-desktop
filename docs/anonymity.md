# Anonimity

> “Democracy requires Privacy as much as Freedom of Expression.” Anonymous

## [I2P](https://geti2p.net/en/about/intro)

* Router Console accessible via web browser at [localhost:7070](http://localhost:7070).
* http proxy is `http://127.0.0.1:4444`
* http://identiguy.i2p/

## Use [Tor](https://github.com/ajvb/awesome-tor) as a socks5 proxy

### Firefox with [SwitchyOmega](https://addons.mozilla.org/en-US/firefox/addon/switchyomega/)

![tor](https://i.imgur.com/OeUgl6W.png)
![proxy](https://i.imgur.com/7PEcbNm.png)

💩 [List of websites blocked in Russia](https://en.wikipedia.org/wiki/List_of_websites_blocked_in_Russia) 💩

### Telegram Desktop

![telegram-desktop](https://i.imgur.com/fJ82MBK.png)

## Tor Browser

![tor-browser](https://i.imgur.com/QnBy41v.png)

## Wrap any programm with `torsocks`

```sh
torsocks curl ifconfig.me
```

## Block ads and trackers

[uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)

## DNS over TLS with kresd

[services.kresd](https://github.com/ksevelyar/dotfiles/blob/42b8264d1b259c99f887be38224f3ae0a62448c5/modules/net/firewall-desktop.nix#L4-L14)

## Use VPN if you need anonymity or Spotify

`openvpn` preinstalled, you can try free [ProtonVpn](https://protonvpn.com/).

## Shell

### Don't write command to history

Prefix your sensitive commands (pass and tomb kind of stuff) with space: ` pass`.

This way your telling your shell to not keep it in history.

### Delete sensitive commands form history with fuzzy matching

You can sanitize history like this:

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
