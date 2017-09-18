# Castle Winbuntu

First, you'd do well to read an excellent blog post from Jessie Frazelle on the nuts and bolts of the Windows Subsystem for Linux available here: https://blog.jessfraz.com/post/windows-for-linux-nerds/

This repo is totally a WIP, and my initial attempt at getting something functional across the Windows Subsystem for Linux (Bash on Ubuntu), that I can also use on Centos 7 (Just as an appreciative note, most of my dotfiles are a curation of super-useful things I've lifted from others, such as @jessfrazz and @natemccurdy --who constantly inspire me through their generosity...thank you both!). At present, I've been running things through ConEmu, since it's the only terminal that I've found that (sort of) has tabs (However I'm currently trying out Hyper.js ~which shows some real promise as a contender!~).

One additional thing that I'll note here, is that simply removing and reinstalling WSL is *supposed to* upgrade you from Ubuntu 14.04 to 16.04.  In my instance this was not the case, and I ended up needing to upgrade with the following:


*From cmd:*
```
lxrun /setdefaultuser root
From bash as root:

wget http://mirrors.kernel.org/ubuntu/pool/main/s/sudo/sudo_1.8.9p5-1ubuntu1.1_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/main/p/procps/procps_3.3.9-1ubuntu2_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/main/s/strace/strace_4.8-1ubuntu5_amd64.deb
dpkg -i sudo_1.8.9p5-1ubuntu1.1_amd64.deb
dpkg -i procps_3.3.9-1ubuntu2_amd64.deb
dpkg -i strace_4.8-1ubuntu5_amd64.deb
```

*Then I had to do this to get ssh to work again:*
```
sudo chmod 0666 /dev/tty
```

Mainly, the reason why I attempted the upgrade was due to a couple of *really* frustrating issues, a) Several issues with my vim plugins and the stock version of vim that ships with Ubuntu 14.04, and b) Issues getting sudo to work properly/consistently with my user.  YMMV, as to your own experience, but since this wasn't at all a straightforward process for me, I'm including these instructions in case you run into something similiar.

Moving on...

### Bash

1. I'm a pretty big fan of Bash-it, which, despite a few missing/broken items, still works pretty well on WSL:)  Install it with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bash-it/bash-it/master/install.sh)"` (currently, running a special theme, i.e. powerline-multiline slows things down to a mere crawl, so I'd recommend limiting your customization...)


### Homesick

1. I'm also a big fan of managing my dotfiles across different distributions with Homesick (I've tried the Makefile approach w/ symlinks, etc. but have found that I'm not as smart as people like Jessie Frazelle, and that Homesick limits the stuff I have to keep track of in my head, --ultimately a more sustainable method of organization and deployment for me :). You'll first need to install ruby, then `gem install homesick`
1. Clone this castle with `homesick clone rodtreweek/winbuntu`
1. Create the symlinks with `homesick link winbuntu`

### Vim plugins

I love, love, love vim-plug. You will too. I promise :)
https://github.com/junegunn/vim-plug

1. Vimplug Install: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
1. Add a vim-plug section to your ~/.vimrc (or ~/.config/nvim/init.vim for Neovim):
https://github.com/junegunn/vim-plug#usage
1. Setting up YouCompleteMe is unfortunately still a WIP at the moment, mainly due to the older versions of vim packaged with both Ubuntu Trusty and Xenial. If you want Vim 8 (like I typically do) then you'll need to build this from source by following the instructions here: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source . There are a whole bunch of other things you'll likely need to sort out if you want, for instance, golang completion to work properly (again, still a wip for me currently), and likely end up with a combination of YCM with vim-git pulling in additonal binaries, etc...I'll add more to this section once I get this figured out (It's working on Centos 7 for me now...but WSL with Xenial is still eluding me slightly...)
    

### Fonts

I've included a .fonts directory that should have a large number of useful fonts.  Here's also the link to a patched Inconsalata Awesome font:

1. Download and install an Awesome patched font:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>
2. Again, I'm currently using ConEmu for my terminal, which although I'm not super-fond of the result, does allow for this font to be loaded up and used...Frankly, I am still finding this adjustmment chief among my many challenges in establishing/adopting a reasonable dev workflow on Windows...I've tried wsltty, which was fine --but didn't have (at least any obvious way) to do tabs, ~and am now looking squarely at Hyper.js which  I'll probably be switching to...~).



More to come, such as getting powerline-multiline to work ~with Hyper.js~, etc....

