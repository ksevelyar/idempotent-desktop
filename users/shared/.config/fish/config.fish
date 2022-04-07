set fish_greeting

set -x PATH $PATH ~/.npm-global/bin
set -x ERL_AFLAGS "-kernel shell_history enabled" # save iex history

set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd --type d .'

zoxide init fish | source

function ssht
  ssh -t $argv[1] 'tmux new -A -s 🦙'
end

function pgen
  gopass generate -s -c $argv[1] 42 # if you can type your password it's no good
end

set -u DEFAULT_USER (whoami)
