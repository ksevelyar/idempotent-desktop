# [Nvim](https://github.com/ksevelyar/dotfiles/blob/master/modules/packages/nvim.nix)

![screen](https://i.imgur.com/fhAtYZY.png)

Integrated with `lsp`, `fzf`, `fd`, `rg`.

## Learn

You can start with built-in `:Tutor`

## Bindings

### Leader Key

The "Leader key" is a way of extending VIM's shortcuts by using sequences of keys to perform a command. The leader key is `<Space>`.

`<Space>j` navigate down

`<Space>k` navigate up

`<Space>f` find current file in NerdTree

`<Space>g` show changed git files with FZF

`<Space>.` search files in the current dir

`<Space>r` search files by content in the project

`<Space>m` show most recent files

`<Space>t` toggle NerdTree (file browser)

`<Space>f` find current file in NerdTree

`<Space>p` copy filepath of opened buffer

`<Space>v` vertical split

`<Space>h` horizontal split

`<Space>c` Comment/Uncomment Line

`<Space>i` Togle indentation guides

`<Space>w` write current file

`<Space>f` find current file in NerdTree

`<Space>d` cut line

`<Space>u` toggle undo tree

`<Space>o` check orphography

`<Space>y` show clipboard history

### Git

`[c` next git chunk

`]c` prev git chunk

### Useful built-in commands

Exit and save: `ZZ`
Exit witout save: `ZQ`

You can undo your actions with `u` and redo with `Ctrl-R`.

`<Ctrl>6` switch to previous file

`gg` move to top

`G` move to botom

`:42` move to line 42

`:retab` replace tabs with spaces

`<Shift>*` search word under cursor

`/` incremental search

`:%s/foo/bar` replace foo to bar in file

Select lines with `Shift+V`, then type `:sort<Enter>` to sort lines alphabetically.

### Goyo

`\`

### Misc

`:Colors` set color theme with fzf

### Links

- [programmingfonts.org](https://www.programmingfonts.org/)
