# dotfiles

Trying to cleanup my mess

Make sure you clone this repo to `~/.dotfiles` before linking anything.

```
git clone git@github.com:gregoriokusowski/dotfiles.git ~/.dotfiles
```

## Shell

Given apple is now shipping with zsh by default, why not?
ohmyzsh was a bit slow on my old machine, so I'll be using antibody

* z
* vi bindings
* git auto-complete that works with aliases

### Installation

Link what is needed:

```
echo "source ~/dotfiles/.zsh/default.zsh" >> ~/.zshrc
```

## Tmux

Simple config:

* `shift+left` and `shift+right` to switch windows
* Prefix is set to `ctrl+a`
* vi-keybindings, `prefix` + `hjkl` to switch panes
* `prefix+[` to go copy-mode, then `v` and `y` like there is no tomorrow

### Installation

First, download tpm:

```
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

then link the config:

```
cd && ln -sf ~/.dotfiles/.tmux.conf
```

## Window management

Way to manage windows from the keyboard:
Main prefix: `ctrl+option+cmd`
Move around with arrows, first interaction it halves, next with thirds.
`prefix+v` maximizes, `prefix+c` centers, `prefix+(e|r)` moves to other displays.

(Rectangle)[https://rectangleapp.com/] is the new way to go since Spectacle is no more maintained.
Other options like Mjolnir, Hammerspoon and others can be considered.

### Installation

Install Rectangle:

```
brew cask install rectangle
```

Link what is needed:

```
cd ~/Library/Preferences/
ln -sf ~/.dotfiles/rectangle/com.knollsoft.Rectangle.plist
```
