# [Fish](https://fishshell.com/)

<video width="100%" height="auto" controls>
  <source src="/fish.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>


💜 Fish is one of the saniest software I've seen.

Almost vanilla [config](https://github.com/ksevelyar/idempotent-desktop/blob/master/home/.config/fish/config.fish), a lot of faster than zsh/zim bundle with the same functionality.

## `fish-config`

Use `fish-config` to configure it with GUI.

## Fish Prompt

## Fuzzy change directory with z.lua

`/e/nixos j
0.25       /c/js
0.5        /etc/nixos/modules
1.25       /storage/vvv
1.5        /etc
2.5        /home/ksevelyar/Wallpapers
3.5        /c/life
4.5        /etc/nixos/home/.config/tridactyl
5.5        /home/ksevelyar/.navi
5.5        /home/ksevelyar/.password-store
8          /c/rust
11.5       /c/joker.vim
16         /c/exs/korean_numbers
24         /etc/nixos/docs
24.5       /home/ksevelyar/Downloads
32         /c
44         /etc/nixos/.secrets
99         /c/resume
374        /tmp
8752       /etc/nixos
/e/nixos j secr
/e/n/.secrets`

`j nix` will switch to `/etc/nixos`.
`j Do` will switch to `/home/ksevelyar/Downloads`.

You can use `z` instead of `j`, `j` is z.lua alias.

## Fuzzy change directory with FZF

Press `Alt+C`

## Fuzzy find file

Type `v <Alt>-t` or `v -o (fzf)`

## [Git aliases](https://github.com/ksevelyar/idempotent-desktop/blob/master/home/.config/fish/functions/git_aliases.fish)

## Don't use cd

you can run `/code` instead of `cd /code`
