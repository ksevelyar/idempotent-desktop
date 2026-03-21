# Debug

## nixos-option
Inspect options:

```
nixos-option home-manager.users.ksevelyar.home.pointerCursor
nixos-option home-manager.users.ksevelyar.home.sessionVariables
```

## repl
```
cd /etc/nixos
nix repl
:lf .

outputs.nixosConfigurations.hk47.config.fonts.fontconfig
```
