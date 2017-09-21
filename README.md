# Castle Winbuntu

As suggested by the title, this is my [Homesick](https://github.com/technicalpickles/homesick) Castle intended for use on the Windows Subsystem for Linux (WSL for short, aka bash/Ubuntu on Windows).

Before continuing, I'd recommend that you first read this excellent blog post from former Docker/Google Engineer, now core member of Microsoft's WSL/container development team, [Jessie Frazelle](https://github.com/jessfraz), discussing the nuts and bolts of WSL: https://blog.jessfraz.com/post/windows-for-linux-nerds/  

It should also be noted that prior to getting *too* precious about using WSL exclusively as your one-and-only-personal-development-workflow-oasis, you'll want to be aware that WSL is *hightly* Windows build-dependent, meaning that certain things you might expect to "just work" in Ubuntu/Bash *may only be supported in more recent builds, or perhaps offered exclusively through the Windows Insider Program* (In my case, this was a number of unexpected limitations surrounding golang development, overlapping with Vim and some of its code-completion plugins.).

You can easily check your Windows build version by simply hitting the Windows key on your keyboard, and typing "winver", then checking the version against [the release notes here](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes)).

Generally speaking, you'll likely want to be on at least [build 14905](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes#build-14905) to support restartable system calls (otherwise, you might start seeing near-constant "read |0: interrupted system call" errors when trying to pretty much do anything with Golang...there's a pretty thorough discussion of this [here](https://github.com/Microsoft/BashOnWindows/issues/1198))

Also, just in case you arrived here expecting something other than a somewhat arbitrary, frequently naive, often opinionated, potentially broken, otherwise comically/perplexingly/stubbornly idiosyncratic collection of loosely-related, less-scientific/more-anecdotal, - yet earnestly well-intentioned sharing of observations, suggestions, and easily deployable general purpose configuration files and installation instructions, - consider this the usual YMMV, normal rules/warnings apply motd :)

Presently, I'm also using ConEmu as my terminal application, as it feels most similiar to Iterm2, which I had grown quite fond of (having now tried Hyper.js, wsltty, and a few others I'm now forgetting, it's the one I favor currently) and supports tabbed-sessions, ~which I can't really live without~ which I've been loathe to relinquish while my trepidation in relying solely on tmux slowly diminishes ;)

One additional thing that I should also note, is that simply removing and reinstalling WSL is *supposed to* upgrade you from Ubuntu 14.04 to 16.04.  However, despite what I was pretty sure was a supported build, this didn't happen for me (it simply hung indefinitely at the command line, even after I fully uninstalled, rebooted, then repeated the lxrun install..I finally had to kill it, -and was still left with 14.04 in the end...) 

I was finally able to upgrade to 16.04 using the following set of commands:


*From cmd:*
```
lxrun /setdefaultuser root
```
*From bash as root:*
```
sudo do-release-upgrade
```
*Then:*
```
wget http://mirrors.kernel.org/ubuntu/pool/main/s/sudo/sudo_1.8.9p5-1ubuntu1.1_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/main/p/procps/procps_3.3.9-1ubuntu2_amd64.deb
wget http://mirrors.kernel.org/ubuntu/pool/main/s/strace/stradpkg -i sudo_1.8.9p5-1ubuntu1.1_amd64.deb
ce_4.8-1ubuntu5_amd64.deb
dpkg -i procps_3.3.9-1ubuntu2_amd64.deb
dpkg -i strace_4.8-1ubuntu5_amd64.deb
```

*Then I had to do this to get ssh to work again:*
```
sudo chmod 0666 /dev/tty
```

The decision to upgrade was mainly prompted by a couple of *really* frustrating issues that I thought would be resolved in the WSL implementation of Ubuntu 16.04: a) several of my Vim plugins didn't work with the stock version of Vim that ships with Ubuntu 14.04 (I ended up building Vim 8 from source due to other limitations I encountered with the YouCompleteMe plugin, so this consideration was ultimately moot), and b) the routine difficulty I was having with getting sudo to work predictably/reliably, i.e. `sudo apt-get install` would typically hang, and I was constantly having to exit my shell to perform trivial tasks as root.

While upgrading was perhaps the right decision for other reasons, it really didn't resolve either of the issues I'd sought to remedy; the YCM plugin still complained about the version of Vim, and `sudo apt-get install` was still busted. I finally resolved this by downgrading several packages (--see the `wget` and `dpkg -i` instructions above..) however each time I'm tempted to run `sudo apt-get update`, I'm again reminded that this will likely break sudo, and I will need to execute the downgrade steps once again.  Again, this is all pretty build/environment specific, and as mentioned earlier YMMV as to your own experience. Since this was a much less straightforward process than what I was expecting, I'm including this here just in case it's helpful to others:)

Also, just a super-appreciative shout-out here before moving on...most of my dotfiles are a curation of extremely useful things I've either iterated on, --or simply lifted outright from others. Several are sourced from [Jessie Frazelle](https://github.com/jessfraz/dotfiles), who through her work with Docker, Google, (and now Microsoft!), continues to impressively shape many notable innovations while promoting OSS and remaining unfailingly generous in sharing her collected functions, aliases, and remarkably empathic and insightful guidance on a range of engineering/development issues, -- and also [Nate Mccurdy](https://github.com/natemccurdy/dotfiles) from Puppet, who - in addition to inspiring the creation of this particular repo featured here- continues to generously offer an elegantly tailored, thoughtfully maintained and rigorously "customer-prem battle-tested" configuration for a rapidly deployable Ruby/Puppet development workflow  --- You constantly inspire me through your intelligence and generosity --- Thank you both!).


Moving on now...

### Bash

1. I'm a pretty big fan of Bash-it (or alternately there's the excellent oh-my-zsh), which, despite a few missing/broken items, still works pretty well on WSL:)  Install it with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bash-it/bash-it/master/install.sh)"` 

*Note that currently running a special theme in Bash-it, i.e. powerline-multiline slows things down intolerably, -I'd recommend limiting your customization if speed is important to you (although I haven't tried it yet, it's possible that things are a bit snappier with oh-my-zsh...)


### Homesick

1. I'm also a big fan of managing my dotfiles across different distributions with [Homesick](https://github.com/technicalpickles/homesick). Homesick limits the stuff I have to keep track of in my head, --ultimately a more sustainable method of organization and deployment for me :). You'll first need to install ruby, then `gem install homesick`
1. Clone this castle with `homesick clone rodtreweek/winbuntu`
1. Create the symlinks with `homesick link winbuntu`

### Vim plugins

I love, love, love vim-plug. You will too. I promise :)
https://github.com/junegunn/vim-plug

1. Vimplug Install: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
1. Add a vim-plug section to your ~/.vimrc (or ~/.config/nvim/init.vim for Neovim):
https://github.com/junegunn/vim-plug#usage
1. Setting up YouCompleteMe natively to support code-completion in WSL is unfortunately still a WIP for me, and tbth, a mostly failed experiment :( This appears to be mainly due to the limitations with my Windows/WSL build, although the dated versions of vim packaged with both Ubuntu Trusty and Xenial certainly haven't helped matters. If you want Vim 8 (generally preferred) then you'll need to build it from source by following the instructions here: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source . --Be careful to heed the warning for python2 vs. 3 when building your config, as there are issues when attempting to use both. ***Update - I've since moved on from YCM to vim-mucomplete and polyglot which i'm quite happy with :)***

### Fonts

I've also included a .fonts directory containing a number of fonts I've found useful. Here's also a link to a patched Inconsalata Awesome font that works particularly well with vim-airline:

1. Download and install the Awesome patched font:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>
2. Again, I'm currently using ConEmu for my terminal, and although not perfectly rendered, this font can be pretty easily loaded and used without much difficulty. Frankly, I am still finding the adjustment to using something other than Iterm2 chief among my challenges in establishing a reasonable dev workflow on Windows.  However I've only really begun exploring what's possible with ConEmu, and am always on the lookout for other interesting projects :)

### Boxtarter

Definitely check out Boxstarter [here](http://boxstarter.org/InstallBoxstarter). Install it with [chocalatey](https://chocolatey.org/), the awesome package manager for Windows!  Here are some links to a few gists for use with Boxstarter:
* <https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f>
* <https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9>

### Blogs

Here are a few other blog posts I've found extremely helpful:

* [Dariusz Parys's dev setup](https://medium.com/@dariuszparys/my-windows-10-dev-setup-67d7aecb63a6)
* [David Tran's setup guide](https://davidtranscend.com/blog/windows-terminal-workflow-guide)

I'll be continuing to frequently add/remove/edit items contained within this project (perhaps until I more suitably author a proper blog post elsewhere, limiting the scope of what's contained here to just the relevant installation and deployment details ;)
