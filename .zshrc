source ~/.zsh/default.zsh

eval "$(rbenv init -)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/kusowski/.sdkman"
[[ -s "/Users/kusowski/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/kusowski/.sdkman/bin/sdkman-init.sh"
