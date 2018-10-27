#!/usr/bin/env bash
#
# Run this on a stock Mac to bootstrap it with dotfiles and customizations.
# It should do a mostly automated install if you run this curl command from the command-line:
# curl -O https://raw.githubusercontent.com/rodtreweek/Castle-Winbuntu/master/bootstrap_mac.sh && chmod u+x bootstrap_mac.sh; bash bootstrap_mac.sh

# Ask for the administrator password upfront
echo "Asking for your sudo password upfront..."
sudo -v

# Keep-alive: update existing `sudo` time stamp until this has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install homebrew and git (xcode tools)
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Create our code directory
[[ -d ~/src ]] || mkdir ~/src

# Grab PowerLevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/src/powerlevel9k

# Get Homesick for dotfiles
sudo gem install homesick --no-doc --no-ri
homesick clone rodtreweek/Castle-Winbuntu
homesick symlink Castle-Winbuntu

# Install HomeBrew apps
brew bundle --file=~/.homesick/repos/Castle-Winbuntu/Brewfile
brew cleanup

# Pin Ruby/Python versions so I don't lose all my gems, etc. on upgrade.
brew pin ruby
brew pin ruby-build
brew pin rbenv
brew pin pyenv

# Install some cool ruby things...
gem install rubocop
gem install tmuxinator

# Install vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Get Vim plugins
vim +PlugInstall +qall

# Install Oh My ZSH
# git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# -- Or skip OMZ and install Prezto instead...
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
# Create a new Zsh configuration by copying the Zsh configuration files provided:
#for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
#done

echo "Changing ${USER}'s shell to Brew's zsh..."
sudo dscl . -create "/Users/$USER" UserShell /usr/local/bin/zsh

# Install GVM (Go Version Manager)
echo "Installing Go Version Manager..."
zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

# Install zplug...
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# Get fonts
echo "Downloading Inconsolata fonts to ~/Library/Fonts/"
wget -P ~/Library/Fonts/ https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf

# Get iTerm gruvbox colors
echo "Installing GruvBox colors for iTerm2"
wget https://github.com/morhetz/gruvbox-contrib/raw/master/iterm2/gruvbox-dark.itermcolors
open gruvbox-dark.itermcolors
rm gruvbox-dark.itermcolors

# Run OSX config script
echo "Configuring a bunch of OSX things"
sh ~/.homesick/repos/Castle-Winbuntu/home/bin/osx.sh

echo
echo "Finished!"
echo
echo "All that's left is to configure iTerm2: https://github.com/natemccurdy/dotfiles#colors-and-fonts"
echo
read -r -p "Also, you should reboot. Do that now? [Y/n]: " answer
if [[ $answer =~ ^[Yy]$ ]]; then
  sudo reboot
fi

