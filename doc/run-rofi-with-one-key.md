# Run rofi with one key

## Configure rofi to two hotkeys in your tiling wm, `mod + x` in leftwm for example:

```
[[keybind]]
command = "Execute"
value = "rofi -modi drun -matching fuzzy -sorting-method fzf drun -show"
modifier = ["modkey"]
key = "x"
```

## Add xcape binding to your `up` script:

```
xcape -e 'Super_R=Super_R|X;Super_L=Super_L|X'
```
