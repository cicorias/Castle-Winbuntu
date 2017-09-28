<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/castle_winbuntu_welcome.png" height="250" alt="castle-winbuntu"> [![Travis CI](https://travis-ci.org/rodtreweek/Castle-Winbuntu.svg?branch=master)](https://travis-ci.org/rodtreweek/Castle-Winbuntu)
---

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/castle-winbuntu-action.gif" height="450">

## Welcome!

This is my [Homesick](https://github.com/technicalpickles/homesick) Castle intended for use on the Windows Subsystem for Linux (aka "WSL", or Bash/Ubuntu on Windows).

:watch: [TL;DR](#tldr---the-meat-and-potatoes-of-deploying-the-dotfiles) :fast_forward: :checkered_flag:

If your search for guidance on setting up a reasonable dev environment on WSL has lead you here, I hope that through offering this (fairly opinionated) example configuration/journal and by leveraging the deployable ease available with Homesick, you may find what you seek :) 

But first, as initial preparation for your journey, I'd recommend that you read this excellent blog post from former Docker/Google-Engineer-turned-core-member-of-Microsoft's WSL/Container Development Team, [Jessie Frazelle](https://github.com/jessfraz), discussing the nuts and bolts of WSL: https://blog.jessfraz.com/post/windows-for-linux-nerds/  


## Additional background and some observations...

It should also be noted that prior to getting *too* precious about using WSL exclusively as your all-inclusive, "personal development-workflow-*asis*", you'll want to be aware that WSL is *highly* Windows build-dependent - meaning that certain things you might expect to "just work" in Ubuntu/Bash *may only be supported in more recent builds, or perhaps offered exclusively through the Windows Insider Program*. 

In my case, the full realization of this uncomfortable fact arrived much less swiftly than I would have preferred, in the form of repeated `go build <command-line-arguments>: read |0: interrupted system call` errors that would appear randomly regardless of version, overlapping with frequent (and ultimately insurmountable) Vim code-completion plugin errors.


### Check your Windows build version...


To avoid this pain, you can easily check your Windows build version by simply hitting the Windows key on your keyboard, typing `winver`, then checking the version against [the release notes here](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes).

Generally speaking, you'll likely want to be on at least [build 14905](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes#build-14905) which supports restartable system calls (thus avoiding the dreaded `read |0: interrupted system call` errors mentioned above, and of which a thorough discussion can be found [here](https://github.com/Microsoft/BashOnWindows/issues/1198))


### Choosing a terminal application...


Presently, I'm also using [ConEmu](https://conemu.github.io) as my terminal application, as it feels most similiar to iTerm2, a Mac-specific mainstay that I had grown quite fond of.  Having now tried Hyper.js, wsltty and a few others (the names of which I'm now forgetting), ConEmu - while not an absolutely perfect replacement for iTerm2 - has emerged as the most stable, configurable, and fully-featured of those I have tried. It also offers tabbed-sessions, ~which I can't really live without~ which up to this point has been a firm requirement for me, even as I warm slightly to the exclusive use of tmux to boundary my sessions ;) 

**Update:** I'm now recalling more completely why tabbed-sessions had previously held such appeal for me. While a local tmux config is great for partitioning *local* session boundaries, even if you are careful to detach from them, they are still tethered to a *local* process, -- meaning that the now-in-progress compile of Vim 8 you just kicked-off on a remote host isn't going to withstand the incoming forced-reboot naturally triggered by Windows Update minutes later ;) 

To avoid this potential calamity you *still* need some mechanism by which to automatically start/create or re-attach to existing sessions on remote hosts (and subsequently boundary these sessions).  This is where tabbed-sessions is particulary useful, since each remote connection is represented in it's own tab, more intuitively corresponding in a 1-to-1 manner to a single tmux session on the remote host.  

In the past I had used a specific combination of conditional logic in my tmux.conf and precisely configured `autossh` command to establish and maintain essentially a "close the lid on laptop, drive home, open lid on laptop, trigger vpn connection, wait for sessions to be restored in each tab" - method of persistance (similar to that offered [here](https://github.com/PinkPosixPXE/iterm-auto-ssh)). While automation at this level may not be of interest to everyone, and certainly should be balanced against any potential security implications (for example, at a minimum great care should be taken in preventing ssh-agent process sprawl, etc.), it's hard not to appreciate the friction-free convenience of this configuration  - especially at 3am, and where the increasing frequency of CRITICAL alerts has converged to form a singular, uninterrupted tone, announcing the beginning of a 48 hour work marathon ;)


### Upgrading WSL's Ubuntu to 16.04


One additional observation that I should note is that [while simply removing and reinstalling WSL](https://www.howtogeek.com/278152/how-to-update-the-windows-bash-shell/) is *supposed to* upgrade you from Ubuntu 14.04 to 16.04, this was not true for me, despite what I was pretty sure was a supported build (it simply hung indefinitely at the command line, even after I fully uninstalled, rebooted, then repeated the lxrun install..I finally had to manually kill it, - and was still left with 14.04 in the end...) 

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
dpkg -i sudo_1.8.9p5-1ubuntu1_amd64.deb
dpkg -i procps_3.3.9-1ubuntu2_amd64.deb
dpkg -i strace_4.8-1ubuntu5_amd64.deb
```

*Then I had to do this to get ssh to work again:*
```
sudo chmod 0666 /dev/tty
```

Again, my decision to upgrade was prompted mainly by a pair of *really* frustrating issues that I *thought* would be resolved by upgrading to Ubuntu 16.04: 
* Several of my Vim plugins didn't work with the stock version of Vim that ships with Ubuntu 14.04 (In the end, I actually wound up just building Vim 8 from source due to dependency problems encountered with the Vim YouCompleteMe plugin that persisted even into 16.04).
* The routine difficulty I was having with getting sudo to work predictably/reliably, i.e. `sudo apt-get install` would typically hang, and it seemed like I was constantly having to exit my shell to perform trivial tasks as root.

While upgrading was perhaps the right decision for several other reasons, it really didn't resolve either of the issues I'd sought to remedy initially; the YCM plugin still complained about the version of Vim, and `sudo apt-get install` now seemed even more busted than ever, having added a decorative new `tty error` to it's limited output. I finally resolved this by downgrading several packages (--see the `wget`, `dpkg -i` commands and `/dev/tty` permissions changes noted above...), however each time I was subsequently tempted to run `sudo apt-get update`, I reflexively hesitated, - wondering if doing so might upset the seemingly fragile balance I'd worked to achieve. Again, in retrospect these issues were highly build/environment specific, (and I'll admit due in part to my misunderstanding of how sudo/root actually works with environment variables in WSL), and would seem comparitively rare, especially for those who have already checked their build version for known issues ;) In any case, since this was a much less straightforward and time-consuming process than I had anticipated, I'm including this information in case it might be useful to those as impetuous/impatient as myself :)

### Acknowledgements!

I'd also like to send a super-appreciative shout-out to all those who so generously share their time and effort on Github assisting others in building and shaping rapidly deployable configurations. The bulk of my dotfiles are really just a curation of extremely useful things I've either lightly iterated on, -- or simply lifted outright from others. Several are sourced from [Jessie Frazelle](https://github.com/jessfraz/dotfiles), who through her work with Docker, Google, (and now [Microsoft!](https://github.com/microsoft)), continues to impressively shape many notable innovations while still promoting OSS and remaining unfailingly generous in sharing her collected functions, aliases, and remarkably empathic and insightful guidance on a range of engineering/development issues, -- and also [Nate Mccurdy](https://github.com/natemccurdy/dotfiles) from [Puppet](https://github.com/puppetlabs), who - in addition to providing the principal inspiration for this repo - continues to generously offer his elegantly tailored, thoughtfully maintained and rigorously "customer-prem battle-tested" configuration for a rapidly deployable Ruby/Puppet development workflow  --- *You constantly inspire me through your intelligence and generosity* --- *Thank you both!*


## TL;DR - The "Meat and Potatoes" of deploying the dotfiles...

Ok, I hear ya...moving on now...

### Bash

1. I'm a pretty big fan of both [Bash-it](https://github.com/Bash-it/bash-it) and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), and have been using both somewhat interchangeably lately. Despite a few missing/broken items, they both work pretty well on WSL:)  Install Bash-it with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bash-it/bash-it/master/install.sh)"` 

### Zsh

1. Install oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
1. You may also want to try out the excellent powerlevel9k theme.
  * First, `mkdir ~/src` then `git clone https://github.com/bhilburn/powerlevel9k.git ~/src/powerlevel9k`
  * Create a symlink with `ln -s ~/src/powerlevel9k/powerlevel9k.zsh-theme ~/.oh-my-zsh/custom/themes/powerlevel9k.zsh-theme`.

*Note that for older Windows builds (I believe this may be fixed on recent builds but haven't confirmed this yet...), currently running a special theme in *either Bash-it or oh-my-zsh*, i.e. powerline-multiline for Bash-it or powerlevel9k for oh-my-zsh, slows things down pretty intolerably... - If you're on an older build, I'd recommend limiting your customizations if speed is important to you.


### Homesick

I'm also a big fan of managing my dotfiles across different distributions with [Homesick](https://github.com/technicalpickles/homesick). While more or less a git wrapper offering a set of reasonable conventions for managing dotfile-specific repos (these repos are termed "castles" in Homesick parlance), Homesick helps me keep my configuration files logically separate based on criteria such as distribution or environment, which limits the stuff I have to keep track of in my head, - ultimately a more sustainable method of organization and deployment for me:)
  1. You'll first need to install ruby, then `gem install homesick`
  1. Clone this castle with `homesick clone rodtreweek/castle-winbuntu`
  1. Create the symlinks with `homesick link castle-winbuntu`

### Vim plugins

I love, love, love vim-plug. You will too. I promise :)
https://github.com/junegunn/vim-plug

1. Vim-plug Install: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
1. Add a vim-plug section to your ~/.vimrc (or ~/.config/nvim/init.vim for Neovim). Complete instructions can be found [here](https://github.com/junegunn/vim-plug#usage), but to summarize:
1. Begin the section with `call plug#begin()`
1. List the plugins with `Plug` commands, for example:
    ```
    " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
     Plug 'junegunn/vim-easy-align'
     ```
1. End with `call plug#end()` which updates `&runtimepath` and initializes plugin system
    - Automatically executes `filetype plugin indent on` and `syntax enable`.
      You can revert the settings after the call. e.g. `filetype indent off`, `syntax off`, etc.
1. Reload .vimrc and `:PlugInstall` to install plugins.

1. Setting up YouCompleteMe natively to support code-completion in WSL is ~unfortunately still a WIP for me, and~ tbth, a ~mostly~ failed experiment:( This appears to be mainly due to the limitations with my Windows/WSL build, although the dated versions of Vim packaged with both Ubuntu Trusty and Xenial certainly haven't helped matters. If you want Vim 8 (generally preferred) then you can follow the instructions here to build it from source: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source  - be careful to heed the warning for python 2 vs. 3 when building your config, as there are issues when attempting to use both...). 

***Update*** - I've since moved on from YCM, and am now using [vim-mucomplete](https://github.com/lifepillar/vim-mucomplete) for (fast!) tab-based code-completion and [vim-polyglot](https://github.com/sheerun/vim-polyglot) for syntax highlighting - a combo I've been extremely happy with! :)

#### Fonts

I've also included a .fonts directory that contains a number of fonts I've found useful. You might also be interested in using a patched Inconsalata Awesome font for better terminal compatibility with vim-airline, or you might be interested in having a look at what's offered here: https://github.com/powerline/fonts .

1. Download and install the Inconsolata Awesome patched font from here:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/change_font_in_conemu.gif" height="450">

Frankly, I am still finding the adjustment to using something other than iTerm2 chief among my challenges in establishing a reasonable dev workflow on Windows.  For example, I was a bit frustrated to learn that there is no real equivalent/approximate Windows method to that of the Mac yank/paste to the system clipboard via the use of the familiar `"*y` register , then pasting the captured text without restriction, system-wide with `command + v`. After literally hours of experimenting, each subsequent attempt seeming to add yet another cumbersome layer of abstraction, (aka "Do I *really* need to setup an X server for this??") I finally threw in the towel ~, opting for the clunky `L shift + mouse select`, or for larger copy selections, a `cat <filename>`, then selecting the text with the mouse/touchpad, and `ctrl + c`, `ctrl + v` respectively to copy/paste, which has made me pretty tired of having to constantly type `:set nonu` in vim.~

**Update:** My ConEmu, vim-related copy/paste angst has been substantially diminished upon discovery of this simple checkbox in  **Settings --> Keys & Macro --> Mark/Copy:**

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/conemu-vim-text-select.gif" height="450">

While I don't *love* the considerable amount of trailing whitespace that this captures, or inability to reasonably deal with line-wrapping, this still makes me **a lot** happier now that I don't have to turn off line numbering, or constantly remove leading white space when pasting, for example, into this readme here on Github, etc. :)


## Additional/Optional items...

### Colors

1. Some themes I found for ConEmu! https://github.com/joonro/ConEmu-Color-Themes
1. Gruvbox color scheme for ConEmu: https://gist.github.com/circleous/92c74d284db392a950d64a2b368517a1

### Boxstarter

Definitely check out Boxstarter [here](http://boxstarter.org/InstallBoxstarter). Install it with [chocalatey](https://chocolatey.org/), the awesome package manager for Windows!  Here are some links to a few gists for use with Boxstarter:
* <https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f>
* <https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9>

### Blogs

Here are a few other blog posts I've also found extremely helpful:

* [Dariusz Parys's dev setup](https://medium.com/@dariuszparys/my-windows-10-dev-setup-67d7aecb63a6)
* [David Tran's setup guide](https://davidtranscend.com/blog/windows-terminal-workflow-guide)
* [Andreas Johansson's terminal setup guide](https://medium.com/@Andreas_cmj/how-to-setup-a-nice-looking-terminal-with-wsl-in-windows-10-creators-update-2b468ed7c326)

I'll be continuing to frequently add/remove/edit items contained within this project (perhaps until I author a proper blog post elsewhere, and make what's here a bit more conventional, i.e. much lighter on editorial, heavier emphasis on clear/concise list of installation/configuration steps ;)
