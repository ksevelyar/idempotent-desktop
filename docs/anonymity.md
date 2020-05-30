# Anonimity

There is no such thing as “perfect anonymity.” Instead, you should look at anonymity as more of a spectrum.

You can run tails or kali in [virt-manager](https://i.imgur.com/RzoS3rR.png) `¯\_(ツ)_/¯`

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
