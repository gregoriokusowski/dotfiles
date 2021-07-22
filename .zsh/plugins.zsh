ANTIGEN_LOG=~/.zsh/antigen.log
source ~/.zsh/antigen.zsh

antigen bundle https://github.com/rupa/z.git
antigen bundle https://github.com/mafredri/zsh-async.git
antigen bundle https://github.com/sindresorhus/pure.git@main
antigen bundle https://github.com/zsh-users/zsh-syntax-highlighting.git

antigen apply