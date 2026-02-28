# Agenix

## Define new secret and keys for it in secrets.nix:

```nix
"secrets/xray-3.ksevelyar.age".publicKeys = [ksevelyar hk47];
```

## Edit secret

```
agenix -e secrets/xray-3.ksevelyar.age
```

## Use it in your config by path:


```nix
age.secrets.xray-json = {
  file = ../secrets/xray-1.ksevelyar.age;
};

services.xray = {
  enable = true;
  settingsFile = config.age.secrets.xray-json.path;
};

age.identityPaths = [ "/home/ksevelyar/.ssh/id_ed25519" ];
```
