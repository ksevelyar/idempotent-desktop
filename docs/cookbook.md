# Cookbook

Transfer nixos files to another host:

```sh
rsync -avzhP --delete --exclude configuration.nix --exclude .git /etc/nixos  192.168.0.1:/etc/
```
