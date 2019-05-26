# User configuration sourced by interactive shells
export DEFAULT_USER=$(whoami)

# Zim
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh
