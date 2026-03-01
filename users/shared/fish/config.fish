set fish_greeting

set -x PATH $PATH ~/.npm-global/bin
set -x ERL_AFLAGS "-kernel shell_history enabled" # save iex history

set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd --type d .'

fzf --fish | source
zoxide init fish | source

function pgen # pgen learn/edx.org
    gopass generate -s -c $argv[1] 42 # if you can type your password it's no good
end

function git_pull_all
    for dir in ./*/.git
        git -C (dirname $dir) pull origin main:main --rebase
    end
end

function t # t 12m or t 9m pizza
    set label $argv[2]
    test -z "$label"; and set label "▓▓▓"

    fish -c "sleep $argv[1] && notify-send -u critical -t 0 $label && cvlc --play-and-exit /etc/nixos/assets/audio/timer.wav" &> /dev/null
end

function find-and-replace
    rg $argv[1] -l | xargs sed -i "s/$argv[1]/$argv[2]/g"
end

set -u DEFAULT_USER (whoami)
