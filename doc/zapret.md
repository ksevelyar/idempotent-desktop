# Zapret
## Scan

```
nix shell nixpkgs#iptables nixpkgs#zapret -c blockcheck
```

## Sanity check

```
curl --ipv4 --fail --silent --show-error --location --connect-timeout 3 --max-time 30 https://youtube.com

curl: (28) Connection timed out after 3001 milliseconds
```


## Enable zapret service

```
  services.zapret = {
    enable = true;
    whitelist = [
      "youtube.com"
      "googlevideo.com"
      "ytimg.com"
      "youtu.be"
      "discord.com"
      "discord-attachments-uploads-prd.storage.googleapis.com"
      "googleapis.com"
    ];
    # change for your provider
    params = [
      "--dpi-desync=hostfakesplit"
      "--dpi-desync-ttl=1"
      "--dpi-desync-autottl=-2"
    ];
  };
```

## Verify page

```
curl --ipv4 --fail --silent --show-error --location --connect-timeout 3 --max-time 15 https://youtube.com | rg "</html>"
```
