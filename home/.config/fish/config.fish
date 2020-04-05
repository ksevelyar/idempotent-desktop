set fish_greeting

if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

git_aliases
user_config
set -u DEFAULT_USER (whoami)

alias edit='sudo nvim /etc/nixos/configuration.nix'
alias build='sudo nixos-rebuild switch --upgrade'
alias t='tmux new-session -A -s main'

alias g='git'
alias j='z'
alias u="aunpack"

alias off='sleep 0.5; xset dpms force off; pkill -f gpmdp'
alias pgrep='pgrep --full'
alias pkill='pkill --full'
alias k='killall'

alias v="nvim"

alias k="kubectl"
alias kcd='kubectl config set-context (kubectl config current-context) --namespace '
alias mk='env MINIKUBE_HOME="/code" minikube start --vm-driver kvm2'

alias ncdu_root="sudo ncdu / --exclude /storage --exclude /trash"
alias python_server="python3 -m http.server 9000"
