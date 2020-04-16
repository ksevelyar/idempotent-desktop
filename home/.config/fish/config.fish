set fish_greeting

if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

git_aliases
set -u DEFAULT_USER (whoami)

alias k="kubectl"
alias kcd='kubectl config set-context (kubectl config current-context) --namespace '
alias mk='env MINIKUBE_HOME="/code" minikube start --vm-driver kvm2'

alias ncdu_root="sudo ncdu / --exclude /storage --exclude /trash"
