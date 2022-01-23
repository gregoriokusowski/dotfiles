echo "setting up zsh"

ln -sf ~/dotfiles/.zsh ~/.zsh
echo "source ~/dotfiles/.zsh/default.zsh" >> ~/.zshrc
zsh -c echo "configuring zsh..."

echo "setting up tmux"
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

echo "setting up nvim"
sudo apt purge neovim
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim fzf silversearcher-ag
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
nvim --headless +PackerInstall +qa

echo "gitconfig" # this cuts out the user info
tail ~/dotfiles/.gitconfig --lines=+4 >> ~/.gitconfig
