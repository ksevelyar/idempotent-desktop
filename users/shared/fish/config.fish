set fish_greeting

set -x PATH $PATH ~/.npm-global/bin
set -x ERL_AFLAGS "-kernel shell_history enabled" # save iex history

set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd --type d .'

set -gx BARTIB_FILE ~/.activities.bartib

zoxide init fish | source

function ssht # ssht skynet.local
    ssh -t $argv[1] 'tmux new -A -s 🦙'
end

function pgen # pgen learn/edx.org
    gopass generate -s -c $argv[1] 42 # if you can type your password it's no good
end

function t # t 12m or t 9m pizza
    set label $argv[2]
    test -z "$label"; and set label "▓▓▓"

    fish -c "sleep $argv[1] && notify-send -u critical -t 0 $label && paplay /etc/nixos/assets/audio/timer.wav" &
end

function find-and-replace
    rg $argv[1] -l | xargs sed -i "s/$argv[1]/$argv[2]/g"
end

set -u DEFAULT_USER (whoami)
