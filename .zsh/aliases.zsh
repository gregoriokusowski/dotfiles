# General
alias la="ls -lash"
alias k="kubectl"
alias g="git"
alias d="docker"
alias dc="docker-compose"
alias v="nvim"
alias vi="nvim"
alias ☕="caffeinate -d"

# docker

# dot -Tpng -o output.png input.dot
# fswatch -0 input.dot | xargs -0 -I {} dot -Tpng -o output.png input.dot
alias dot='docker run --rm -v `pwd`:/graphviz markfletcher/graphviz dot'
alias ctop='docker run --rm -ti --name=ctop -v /var/run/docker.sock:/var/run/docker.sock quay.io/vektorlab/ctop:latest'
