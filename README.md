# Castle Winbuntu

First, you'd do well to read an excellent blog post from Jessie Frazelle on the nuts and bolts of the Windows Subsystem for Linux available here: https://blog.jessfraz.com/post/windows-for-linux-nerds/

Also, before you get too precious about configuring WSL exclusively as your one-and-only development workflow oasis, be aware that WSL is *hightly* Windows build-dependent, and certain things you might fully expect to work(such as golang development, or specifically in my case the use of some vim code-completion plugins...) may only be supported in more recent, or possibly only in Windows Insider Program builds, -or perhaps not at all. (you can easily check your Windows build version by simply hitting the Windows key on your keyboard, and typing "winver", then checking this against [the release notes here](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes)).

Generally speaking, you'll really want to be on at least [build 14905](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes#build-14905) as this release supports restartable system calls (otherwise, you'll likely start seeing near-constant "read |0: interrupted system call" errors when trying to pretty much do anything with Golang...this issue is also pretty thorougly discussed [here](https://github.com/Microsoft/BashOnWindows/issues/1198)

Also, it should be noted that as my initial WIP in getting a sufficiently reproducible cross-platform WSL and CentOS 7 dev workflow configured, you can expect what's offered here to be frequently naive, often opinionated, potentially broken, and perhaps comically idiosyncratic :) The usual warnings/rules apply.

Also, just as a super-appreciative shout-out here...most of my dotfiles are a curation of extremely useful things I've gleaned or lifted outright from others, like @jessfrazz and her immense contributions to docker (presumably continuing with WSL!), and her numerous functions, aliases, and just generally insightful development workflow guidance, and @natemccurdy for his elegant and rigorously efficient approach to ruby/Puppet development and agile-aligned workflow configuration and automated testing --you constantly inspire me through your intelligence and generosity...Thank you both!). 

Presently, I'm also using ConEmu as my terminal application, as it feels the most similiar to iterm2, which I had grown quite fond of (at least to me, having now tried Hyper.js, wsltty, and a few others I'm now forgetting..) and supports tabbed-sessions, which I can't really live without.

One additional thing that I'll note here, is that simply removing and reinstalling WSL is *supposed to* upgrade you from Ubuntu 14.04 to 16.04.  However in my case, for whatever reason, this didn't happen (hung indefinitely at the command line after I did an lxrun full uninstall, rebooted, then the lxrun install. command...I had to finally kill it in the end, -and was still left with 14.04...) I ended up finally managing to upgrade to 16.04 with the following set of commands:


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

Mainly, the only real reasons why I felt I needed to upgrade came down to a couple of *really* frustrating issues, a) several of my vim plugins didn't work with the stock version of vim that ships with Ubuntu 14.04 (which I ultimately just ended up building from source anyway), and b) I was having routine difficulty getting sudo to work predictably/consistently, and thought that upgrading might solve the problem (it didn't...or at least not initially...see the above "sudo downgrade" instructions....).  YMMV, as to your own experience, and again a lot of these issues are build/environment specific, but since this wass a much less than straightforward process for me, I'll include these instructions in case you find them useful.

Moving on now...

### Bash

1. I'm a pretty big fan of Bash-it (or alternately there's the excellent oh-my-zsh), which, despite a few missing/broken items, still works pretty well on WSL:)  Install it with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bash-it/bash-it/master/install.sh)"` 

*Note that currently running a special theme in Bash-it, i.e. powerline-multiline slows things down intolerably, -I'd recommend limiting your customization if speed is important to you (although I haven't tried it yet, it's possible that things are a bit snappier with oh-my-zsh...)


### Homesick

1. I'm also a big fan of managing my dotfiles across different distributions with Homesick. Homesick limits the stuff I have to keep track of in my head, --ultimately a more sustainable method of organization and deployment for me :). You'll first need to install ruby, then `gem install homesick`
1. Clone this castle with `homesick clone rodtreweek/winbuntu`
1. Create the symlinks with `homesick link winbuntu`

### Vim plugins

I love, love, love vim-plug. You will too. I promise :)
https://github.com/junegunn/vim-plug

1. Vimplug Install: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
1. Add a vim-plug section to your ~/.vimrc (or ~/.config/nvim/init.vim for Neovim):
https://github.com/junegunn/vim-plug#usage
1. Setting up YouCompleteMe natively to support code-completion in WSL is unfortunately still a WIP for me, and tbth, a mostly failed experiment :( This appears to be mainly due to the limitations with my Windows/WSL build, although the dated versions of vim packaged with both Ubuntu Trusty and Xenial certainly haven't helped matters. If you want Vim 8 (generally preferred) then you'll need to build it from source by following the instructions here: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source . --Be careful to heed the warning for python2 vs. 3 when building your onfig, as there are issues when attempting to use both.

### Fonts

I've included a .fonts directory where I've been collected a number of useful fonts.  Here's a link to a patched Inconsalata Awesome font as well which I've found to work particularly well with vim-airline:

1. Download and install the Awesome patched font:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>
2. Again, I'm currently using ConEmu for my terminal, and although not perfectly rendered, this font can be pretty easily loaded and used without much difficulty. Frankly, I am still finding the adjustmment to using something other than iterm2 chief among my many challenges in establishing/adopting a reasonable dev workflow on Windows.  Howeverv I've only really begun exploring what's possible with ConEmu, and am always on the lookout for other interesting projects :)


