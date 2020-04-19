source <(antibody init)
antibody bundle < ~/.zsh/.zsh_plugins.txt
#antibody bundle < ~/.zsh/.zsh_plugins.txt > ~/.zsh/.zsh_plugins.sh
#source ~/.zsh/.zsh_plugins.sh

# Oneliner prompt
prompt_newline='%666v'
PROMPT=" $PROMPT"

source ~/.zsh/aliases.zsh

# Useful for piping.
## Example: ls | x .upcase
## Examples: docker images | xs .last
x() { ruby -ne "puts \$_$1" }
xs() { ruby -ane "puts \$F$1" }

# Git proper auto-complete
# https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
# Dropping the warning message manually since the zsh autocomplete doesn't consider aliases defined via git
# Also, bash one is "deprecated" since 2012 https://github.com/git/git/commit/d8b453149cdd0f900f2add9d891594cec37e3a56
source ~/.zsh/git-completion.bash


export TERM=xterm-256color
export EDITOR="nvim"
export OPENER=$EDITOR

# VI
## Enable vi keybindings
bindkey -v # previously set -o vi
## Enable editing line in vi by pressing "v" in normal mode
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# History
# Enable Ctrl+R to search history like old bash
bindkey '^R' history-incremental-search-backward
# Enable incremental history
setopt inc_append_history

# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
# To differentiate aliases from other command types
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=magenta,italic'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=magenta'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(rbenv init -)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/kusowski/.sdkman"
[[ -s "/Users/kusowski/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/kusowski/.sdkman/bin/sdkman-init.sh"
