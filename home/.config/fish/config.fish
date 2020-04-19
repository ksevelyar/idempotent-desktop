set fish_greeting

if not functions -q fisher
  echo 'Installing fisher...'
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl -s https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher > /dev/null 2>&1
  echo -e "Done.\n"
end

if [ ! -e ~/.config/nvim/autoload/plug.vim ]
  echo 'Installing plug-vim...'
  curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim +PlugInstall +qall > /dev/null
  echo -e "Done.\n"
end

# build-and-write-live-usb-min /dev/sdc
function build-and-write-live-usb-min
  sudo lsblk -f

  cd /tmp
  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb-minimal.nix -o live-usb-min
  sudo dd bs=4M if=live-usb-min/iso/nixos.iso of=$argv status=progress && sync

  lsblk -f
end

# build-and-write-live-usb /dev/sdc
function build-and-write-live-usb
  sudo lsblk -f

  cd /tmp
  nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=/etc/nixos/live-usb.nix -o live-usb
  sudo dd bs=4M if=live-usb/iso/nixos.iso of=$argv status=progress && sync

  lsblk -f
end

git_aliases
set -u DEFAULT_USER (whoami)
