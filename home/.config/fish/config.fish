set fish_greeting

if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl -s https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  # fish -c fisher
end

if [ ! -e ~/.config/nvim/autoload/plug.vim ]
  echo 'Installing plug-vim...'
  curl -sfLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim +PlugInstall +qall > /dev/null
  echo 'Done.'
end

git_aliases
set -u DEFAULT_USER (whoami)
