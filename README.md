# Castle Winbuntu

This is totally a WIP, and my (somewhat clumsy) initial attempt at getting something functional across the Windows Subsystem for Linux (Bash on Ubuntu) and Centos 7 all running through the ConEmu terminal emulator. This is still totally a work in progress.

### Bash

1. I'm a pretty big fan of bash_it, which despite a few missing items, still works pretty well on WSL.  Install it with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bash-it/bash-it/master/install.sh)"` (currently, running a special theme, i.e. powerline-multiline slows things down to a mere crawl, so I'd recommend limiting your customization...)


### Homesick

1. I'm a pretty big fan of managing things with Homesick (I've tried the custom Makefile approach w/ symlinks, etc. but have found Homesick to be a more sustainable method of organization and deployment. Install it with `gem install homesick`
1. Clone this castle with `homesick clone rodtreweek/winbuntu`
1. Create the symlinks with `homesick link winbuntu`

### Vim plugins
https://github.com/junegunn/vim-plug

1. Vimplug Install: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
1. Add a vim-plug section to your ~/.vimrc (or ~/.config/nvim/init.vim for Neovim):

Begin the section with call plug#begin()
List the plugins with Plug commands
call plug#end() to update &runtimepath and initialize plugin system
Automatically executes filetype plugin indent on and syntax enable. You can revert the settings after the call. e.g. filetype indent off, syntax off, etc.
1. Setup YouCompleteMe:
    1. `brew install cmake`
    1. `~/.vim/plugged/YouCompleteMe/install.py`

#### .vim

My `.vim` dotfiles are here as well:
[github.com/rodtreweek/.vim](https://github.com/rodtreweek/.vim).


### Fonts

Install Awesome patched fonts to make vim-airline happy:

1. Download and install an Awesome patched font:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>
2. Switch iTerm2 to use that font for both **Font** and **Non ASCII Font**


