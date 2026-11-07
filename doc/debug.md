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

## env
```
env | rg -i cursor
```

## Stress test
Run a 15-minute CPU and memory stress test with `stress-ng`:

```fish
nix run nixpkgs#stress-ng -- \
  --cpu 0 \
  --vm 8 \
  --vm-bytes 80% \
  --vm-method all \
  --matrix 0 \
  --timeout 15m \
  --metrics-brief
```
