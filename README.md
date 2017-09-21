# Castle Winbuntu

First, you'd do well to read this excellent blog post from former Docker/Google Engieer, - and as of last week, newest member of Microsoft's core WSL/container development team, Jessie Frazelle discussing the nuts and bolts of the Windows Subsytem for Linux: https://blog.jessfraz.com/post/windows-for-linux-nerds/  

Now, before proceeding further, it should also be noted that prior to getting all precious about using WSL exclusively as your one-and-only-personal-development-workflow-oasis, you'll want to be aware that WSL is *hightly* Windows build-dependent, meaning that certain things you might otherwise expect to be available/configurable from Ubuntu/Bash and that typically "just work" in these environmets (such as golang development, or specifically in my case the use of some vim code-completion plugins...) *may only be supported in more recent builds, or perhaps offered exclusively through the Windows Insider Program.*

You can easily check your Windows build version by simply hitting the Windows key on your keyboard, and typing "winver", then checking the version against [the release notes here](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes)).

Generally speaking, you'll likely want to be on at least [build 14905](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes#build-14905) to support restartable system calls (otherwise, you might start seeing near-constant "read |0: interrupted system call" errors when trying to pretty much do anything with Golang...there's a pretty thorough discussion of this [here](https://github.com/Microsoft/BashOnWindows/issues/1198))

Also, just in case you arrived here expecting something other than a somewhat arbitrary, frequently naive, often opinionated, potentially broken, otherwise comically/perplexingly/stubbornly idiosyncratic collection of loosely-related, less-scientific/more-anecdotal, -yet well-intentioned sharing of observations/suggestions and variously useful/easily deployable dot/configuration files, -consider this your usual YMMV, normal rules/warnings apply motd :)

Presently, I'm also using ConEmu as my terminal application, as it feels the most similiar to Iterm2, which I had grown quite fond of (having now tried Hyper.js, wsltty, and a few others I'm now forgetting, it's the one I favor currently) and supports tabbed-sessions, which I can't really live without.

One additional thing that I should also note, is that simply removing and reinstalling WSL is *supposed to* upgrade you from Ubuntu 14.04 to 16.04.  However, despite what I was pretty sure was a supported build, this didn't happen for me (it simply hung indefinitely at the command line, even after I fully uninstalled, rebooted, then repeated the lxrun install..I finally had to kill it, -and was still left with 14.04 in the end...) 

I was finally able to upgrade to 16.04 using the following set of commands:


*From cmd:*
```
lxrun /setdefaultuser root
From bash as root:

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

My decision to upgrade was really based on the presence of a couple of *really* frustrating issues that I thought would be resolved by upgrading, a) several of my vim plugins didn't work with the stock version of vim that ships with Ubuntu 14.04 (which I ultimately just ended up building from source anyway...), and b) the routine difficulty I was having with getting sudo to work predictably/reliably, i.e. sudo apt-get, etc. (ultimately upgrading to 16.04 really only improved things marginally for me...see the above "sudo downgrade" instructions....).  Again, this is all pretty build/environment specific, and as usual YMMV as to your own experience, but since this was a much less straightforward process than what I was expecting, I'll include these instructions just in case others might find them useful.

Also, just a super-appreciative shout-out here before moving on...most of my dotfiles are a curation of extremely useful things I've gleaneed, --or lifted outright from others, such as @jessfrazz, who has made immense contributions to Docker and OSS (...and presumably will continue with WSL!), and has been unfailingly generous in sharing her collected functions, aliases, and remarkably insightful guidance on creating a sustainable development workflow, as  well as @natemccurdy from Puppet, who in addition to inspiring the creation of this repo right here, continues to generously offer his elegantly tailored, thoughtfully maintained and rigorously "customer-prem" battle-tested configuration for a rapidly deployable ruby/Puppet development workflow  --you constantly inspire me through your intelligence and generosity...Thank you both!).


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
1. Setting up YouCompleteMe natively to support code-completion in WSL is unfortunately still a WIP for me, and tbth, a mostly failed experiment :( This appears to be mainly due to the limitations with my Windows/WSL build, although the dated versions of vim packaged with both Ubuntu Trusty and Xenial certainly haven't helped matters. If you want Vim 8 (generally preferred) then you'll need to build it from source by following the instructions here: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source . --Be careful to heed the warning for python2 vs. 3 when building your config, as there are issues when attempting to use both. ***Update - I've since moved on from YCM to vim-mucomplete and polyglot which i'm quite happy with :)

### Fonts

I've also included a .fonts directory containing a number of fonts I've found useful. Here's also a link to a patched Inconsalata Awesome font that works particularly well with vim-airline:

1. Download and install the Awesome patched font:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>
2. Again, I'm currently using ConEmu for my terminal, and although not perfectly rendered, this font can be pretty easily loaded and used without much difficulty. Frankly, I am still finding the adjustmment to using something other than iterm2 chief among my many challenges in establishing/adopting a reasonable dev workflow on Windows.  Howeverv I've only really begun exploring what's possible with ConEmu, and am always on the lookout for other interesting projects :)
