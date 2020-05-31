# Security

## Pass

### Import your passwords to pass

[pass-import](https://github.com/roddhjav/pass-import#pass-import)

You can use `gopass` for fuzzy matchings (aliased to `p`) or GUI `qtpass` (binded to `Win+p`).

## [Tomb](https://www.dyne.org/software/tomb/)

[Quickstart](https://github.com/dyne/Tomb/wiki/Quickstart)
[Advanced features](https://github.com/dyne/Tomb/wiki/Advancedfeatures)

To create a 100MB tomb called “secret” do:

```sh
tomb dig -s 100 secret.tomb
tomb forge secret.tomb.key
tomb lock secret.tomb -k secret.tomb.key
```

To open it, do `tomb open secret.tomb -k secret.tomb.key`

and after you are done `tomb close`

## Opened ports

[firewall-desktop](https://github.com/ksevelyar/dotfiles/blob/master/modules/net/firewall-desktop.nix)

## Show listening ports

`sudo lsof -Pni | grep -i listen`

## [sshd](https://github.com/ksevelyar/dotfiles/blob/0c25763c040e5a50f393d2c2bb7c6eee616f3729/modules/services/common.nix#L9-L16)

Autostart disabled, use `sudo systemctl start sshd`

The port is 9922. Use `ssh user@host -p 9922` to connect.

In case your sshd is runninng you will see it in polybar with amount of active connects:

![polybar](https://i.imgur.com/zZz3AfZ.png)

The same for x11vnc.

### Check your ssh keys

```bash
bash -c 'for key in ~/.ssh/id_*; do ssh-keygen -l -f "${key}"; done | uniq'
```

> Today, the RSA is the most widely used public-key algorithm for SSH key. But compared to Ed25519, it’s slower and even considered not safe if it’s generated with the key smaller than 2048-bit length.

[upgrade-your-ssh-key-to-ed25519](https://medium.com/risan/upgrade-your-ssh-key-to-ed25519-c6e8d60d3c54)

`ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519`

## Fail2Ban

Currently integrated with `sshd`.

## hardened kernel

You can switch to the hardened kernel with one line: [sysctl.nix](https://github.com/ksevelyar/dotfiles/blob/504570d52ab79463704e4ddcf908f82c5936217e/modules/sys/sysctl.nix#L4-L6)