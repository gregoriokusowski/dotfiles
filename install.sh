echo "setting up zsh"

ln -sf ~/dotfiles/.zsh ~/.zsh
echo "source ~/dotfiles/.zsh/default.zsh" >> ~/.zshrc
zsh -c echo "configuring zsh..."

echo "setting up tmux"
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

echo "setting up nvim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
nvim --headless +PlugInstall +qa

echo "gitconfig" # this cuts out the user info
tail ~/dotfiles/.gitconfig --lines=+4 >> ~/.gitconfig