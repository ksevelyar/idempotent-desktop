# Run from zsh to import history
# mv ~/.local/share/fish/fish_history{,.bak}
# fc -lni 1 | ruby -rtime -r yaml -e 'puts STDIN.inject([]) { |a, l| a << { "cmd" => l[16..-1].strip, "when" => Time.parse(l[0..15]).to_i } }.to_yaml(options = {:line_width => -1})' > ~/.local/share/fish/fish_history
if not test -d ~/.asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout (git describe --abbrev=0 --tags)
  mkdir -p ~/.config/fish/completions; and cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions
end

source "$HOME/.homesick/repos/homeshick/homeshick.fish"

if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

if test -z "$DISPLAY"; and test "$XDG_VTNR" -eq 1
  exec startx
end

git_aliases
user_config
set -u DEFAULT_USER (whoami)

alias g='git'
alias j='z'
alias u="aunpack"

alias off='sleep 1; xset dpms force off'
alias pgrep='pgrep --full'
alias k='killall'

alias rs='bin/rails server webrick'
alias rc='bin/rails console'
alias db='bin/rails dbconsole'
alias rr="bin/rails runner"
alias d="docker"

function yi
  sync_mirrors
  yay -Syyu --noconfirm $argv
end
alias yr='yay -R --noconfirm'
alias yy='yay -S --noconfirm'

function sync_bg
  set -l last_wallpaper (ls -dt1 /storage/Dropbox/pics/wallpapers/* | head -n 1)
  feh --bg-fill --image-bg 'black' $last_wallpaper
end

function asdf_all
  asdf_js
  asdf_ruby
  asdf_python
end

function asdf_haskell
  asdf plugin-add haskell
  set -l latest_version (asdf list-all haskell | grep -v - | tail -1)
  asdf install haskell $latest_version
  asdf global haskell $latest_version

  stack install stack-run
end

function asdf_js
  asdf plugin-add nodejs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

  set -l latest_version (asdf list-all nodejs | tail -1)
  asdf install nodejs $latest_version
  asdf global nodejs $latest_version

  npm i -g stylelint-selector-bem-pattern stylelint-config-recommended-scss stylelint-scss stylelint eslint stylelint-config-standard eslint-config-airbnb-base tern eslint-plugin-vue eslint-plugin-import
  npm i -g prettier eslint-plugin-prettier
end

function asdf_ruby
  asdf plugin-add ruby

  set -l latest_version (asdf list-all ruby | grep -v - | tail -1)
  asdf install ruby $latest_version
  asdf global ruby $latest_version

  gem install rails bundler pry pry-doc awesome_print neovim solargraph rubocop brakeman \
  rails_best_practices slim_lint haml_lint seeing_is_believing
end

function asdf_python
  asdf plugin-add python

  set -l latest_version (asdf list-all python | grep -v - | tail -1)
  asdf install python $latest_version
  asdf global python $latest_version

  pip install --upgrade pip
  pip install --user neovim
end

function sync_mirrors
  pacman -S --noconfirm reflector
  sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
end

function tools
  sync_mirrors

  yay -Syyu --noconfirm ranger spacefm neovim ripgrep git diff-so-fancy gitg fish tmux vtop \
  wget curl openssh util-linux \
  rukbi nerd-fonts-complete fzf fzf-extras mlocate ctags global terminator ncdu \
  pigz pbzip2 \
  xxkb xbindkeys xmonad xmonad-contrib xorg-xinit xorg feh rofi rofi-greenclip redshift dzen2 \
  xcursor-human lxappearance-gtk3 vibrancy-colors paper-icon-theme-git paper-gtk-theme-git numix-icon-theme-git \
  numix-gtk-theme numix-circle-icon-theme-git luv-icon-theme-git korla-icon-theme kiconthemes \
  adwaita-icon-theme arc-gtk-theme arc-icon-theme archdroid-icon-theme elementary-icon-theme \
  reflector \
  ttf-roboto ttf-fira-code ttf-dejavu terminess-powerline-font-git \
  kodi smplayer gpmdp-remote gpmdp atool \
  keepassxc pavucontrol pulseaudio
end

function iminicube
  sudo pacman -Sy --noconfirm libvirt qemu-headless ebtables dnsmasq docker-machine
  yay -Sy --noconfirm docker-machine-driver-kvm2 minikube-bin kubectl-bin

  sudo usermod -a -G libvirt (whoami)

  sudo systemctl enable libvirtd.service --now
  sudo systemctl enable virtlogd.service --now

  sudo virt-host-validate
  minikube config set vm-driver kvm2

  minikube start --vm-driver kvm2
  minikube dashboard
end

source ~/.asdf/asdf.fish
