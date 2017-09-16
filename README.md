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
1. Setting up YouCompleteeMe is unfortunately still a WIP at the moment, mainly due to the older versions of vim packaged with both Ubuntu Trusty and Xenial. If you want Vim 8 (like I typically do) then you'll need to build this from source by following the instructions here: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source . There are a whole bunch of other things you'll need to sort out if you want golang completion to work properly (again, still a wip for me currently), like using a combination of YCM with vim-git, and pulling in additonal binaries, etc...I'll add more to this section once I get this figured out (It's working on Centos 7 for me now...but WSL with Xenial is still not quite useable...)
    

### Fonts

I've included a .fonts directory that should have a large number of useful fonts.  Here's a link to a patched Inconsalata Awesome font as well:

1. Download and install an Awesome patched font:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>
2. I use ConEmu currently for my terminal, which although I'm not super-fond of the result, does allow for this font to be loaded up and used (Frankly, I am still finding this adjustmment chief among my many challenges in establishing/adopting a reasonable dev workflow on Windows...).



More to come....


