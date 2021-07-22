echo "setting up zsh"

echo "source ~/dotfiles/.zsh/default.zsh" >> ~/.zshrc

echo "setting up tmux"
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cd && ln -sf ~/dotfiles/.tmux.conf

