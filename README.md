<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/castle_winbuntu_welcome.png" height="250" alt="castle-winbuntu"> [![Travis CI](https://travis-ci.org/rodtreweek/Castle-Winbuntu.svg?branch=master)](https://travis-ci.org/rodtreweek/Castle-Winbuntu)
---

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/castle-winbuntu-action.gif" height="450">

## Welcome!

This is my [Homesick](https://github.com/technicalpickles/homesick) Castle intended for use on the Windows Subsystem for Linux (aka "WSL", or Bash/Ubuntu on Windows).

:watch: [TL;DR](#tldr---the-meat-and-potatoes-of-deploying-the-dotfiles) :fast_forward: :checkered_flag:

If your search for guidance on setting up a reasonable dev environment on WSL has lead you here, I hope that through offering this (fairly opinionated) example configuration/journal and by leveraging the deployable ease available through Homesick, you may find what you seek :) 

But first, before you so eagerly throw your support behind Microsoft's (at least in the opinion of this writer *extremely welcome*) efforts to be *much more* open-source inclusive, I'd recommend as initial preparation reading [this excellent blog post](https://github.com/jessfraz) from former Docker/Google-Engineer-turned-core-member-of-Microsoft's WSL/Container Development Team, [Jessie Frazelle](http://redmonk.com/jgovernor/2017/09/06/on-hiring-jessie-frazelle-microsofts-developer-advocacy-hot-streak-continues/) discussing the nuts and bolts of WSL.


## Additional background and some observations...

It should also be noted that prior to getting *too* precious about the idea of using WSL exclusively as your seamless "personal development-workflow-*asis*", you'll want to be aware that WSL is *highly* Windows build-dependent - meaning that certain things you might expect to "just work" in Ubuntu/Bash *may only be supported in more recent builds, or perhaps offered exclusively through the Windows Insider Program*. 

In my case, the full realization of this uncomfortable fact arrived much less swiftly than I would have preferred, in the form of repeated `go build <command-line-arguments>: read |0: interrupted system call` errors that would appear randomly regardless of version, then overlap with frequent (and ultimately insurmountable) Vim code-completion plugin errors.


### Check your Windows build version...


To avoid this pain, you can easily check your Windows build version by simply hitting the Windows key on your keyboard, typing `winver`, then checking the version against [the release notes here](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes).

Generally speaking, you'll likely want to be on at least [build 14905](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes#build-14905) which supports restartable system calls (thus avoiding the dreaded `read |0: interrupted system call` errors mentioned above, of which a thorough discussion can be found [here](https://github.com/Microsoft/BashOnWindows/issues/1198))


### Choosing a terminal application...


Presently, I'm also using [ConEmu](https://conemu.github.io) as my terminal application, as it feels most similiar to iTerm2, a Mac-specific mainstay that I had grown quite fond of.  Having now tried Hyper.js, wsltty and a few others (the names of which I'm now forgetting), ConEmu - while not an absolutely perfect replacement for iTerm2 - has emerged as the most stable, configurable, and fully-featured of those I have tried. It also offers tabbed-sessions, ~which I can't really live without~ which up to this point has been a firm requirement for me, even as I warm slightly to the exclusive use of tmux to boundary my sessions ;) 

**Update:** I'm now recalling more completely why tabbed-sessions had previously held such appeal for me. While a local tmux config is great for partitioning *local* session boundaries, even if you are careful to detach from them, they are still tethered to a *local* process, -- meaning that the now-in-progress compile of Vim 8 you just kicked-off on a remote host isn't going to withstand the incoming forced-reboot naturally triggered by Windows Update minutes later ;) 

To avoid this potential calamity you *still* need some mechanism by which to automatically start/create or re-attach to existing sessions on remote hosts (and subsequently boundary these sessions).  This is where tabbed-sessions is particulary useful, since each remote connection can then be represented in *it's own tab* and by logical extension much more intuitively mapped in a 1-to-1 manner to *its own individual tmux session - initiated and maintained on the remote host*.

In the past, since it was common that I might be connected to several remote systems at any given time, it was necessary for me to use this method of tabbed-sessions, along with some conditional logic in both my local and remote .tmux.conf files and precisely configured `autossh` command to establish and maintain essentially a "close the lid on laptop, drive home, open lid on laptop, trigger vpn connection, wait for sessions to be restored in each tab" - method of persistance (similar to that represented [here](https://github.com/PinkPosixPXE/iterm-auto-ssh). While "automation" at this level may not be of interest to everyone, and certainly should be balanced against any potential security implications (for example, at a minimum great care should be taken in preventing ssh-agent process-sprawl, etc.), it's hard not to appreciate the friction-free convenience of this configuration  - especially at 3am when the increasing frequency of CRITICAL alerts has converged to form a singular, uninterrupted tone, announcing the arrival of a 48 hour work marathon ;)


### Upgrading WSL's Ubuntu to 16.04


One additional observation that I should note is that [while simply removing and reinstalling WSL](https://www.howtogeek.com/278152/how-to-update-the-windows-bash-shell/) is *supposed to* upgrade you from Ubuntu 14.04 to 16.04, this was not true for me, despite what I was pretty sure was a supported build (it simply hung indefinitely at the command line, even after I fully uninstalled, rebooted, then repeated the lxrun install..I finally had to manually kill it, - and was still left with 14.04 in the end...) 

I was finally able to upgrade to 16.04 using the following set of commands:


*From cmd:*
```
lxrun /setdefaultuser root
```
*From bash as root:*
```
do-release-upgrade
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
chmod 0666 /dev/tty
```

Again, my decision to upgrade was prompted mainly by a pair of *really* frustrating issues that I *thought* would be resolved by upgrading to Ubuntu 16.04: 
* Several of my Vim plugins didn't work with the stock version of Vim that ships with Ubuntu 14.04 (In the end, I actually wound up just building Vim 8 from source due to dependency problems encountered with the Vim YouCompleteMe plugin that persisted even into 16.04).
* The routine difficulty I was having with getting sudo to work predictably/reliably, i.e. `sudo apt-get install` would typically hang, and it seemed like I was constantly having to exit my shell to perform trivial tasks as root.

While upgrading was perhaps the right decision for several other reasons, it really didn't resolve either of the issues I'd sought to remedy initially; the YCM plugin still complained about the version of Vim, and `sudo apt-get install` now seemed even more busted than ever, having added a decorative new `sudo: no tty present and no askpass program specified` error to it's limited output. I finally resolved this by downgrading several packages (--see the `wget`, `dpkg -i` commands and `/dev/tty` permissions changes noted above...), however each time I was subsequently tempted to run `sudo apt-get update`, I reflexively hesitated, - wondering if doing so might upset the seemingly fragile balance I'd worked to achieve. 

Again, in retrospect these issues were highly build/environment specific, (and I'll admit ~due in part to my misunderstanding of how sudo/su actually works with environment variables in WSL~ *how sudo really just works in general* - see my table [below](#another-quick note-on-sudo/su/root...)), and would seem comparatively rare, especially for those who have already checked their build version for any surprises ;) In any case, since this was a much less straightforward and time-consuming process than I had anticipated, I'm including this information in case it might be useful to the similarly impetuous :)

### Acknowledgements!

I'd also like to send a super-appreciative shout-out to all those who so generously share their time and effort on Github assisting others in building and shaping rapidly deployable configurations. The bulk of my dotfiles are really just a curation of extremely useful things I've either lightly iterated on, -- or simply lifted outright from others. Several were sourced initially from [Jessie Frazelle](https://github.com/jessfraz/dotfiles), who through her work with Docker, Google, (and now [Microsoft!](https://github.com/microsoft)), continues to impressively shape many notable innovations while still promoting OSS and remaining unfailingly generous in sharing her collected functions, aliases, and remarkably empathic and insightful guidance on a range of engineering/development issues, -- and also [Nate Mccurdy](https://github.com/natemccurdy/dotfiles) from [Puppet](https://github.com/puppetlabs), who - in addition to providing the principal inspiration for this repo - continues to generously offer his elegantly tailored, thoughtfully maintained and rigorously "customer-prem battle-tested" configuration for a rapidly deployable Ruby/Puppet development workflow  --- *You constantly inspire me through your intelligence and generosity* --- *Thank you both!*


## TL;DR - The "Meat and Potatoes" of deploying the dotfiles...

Ok, I hear ya...sounds like you're hungry. Here's how to deploy:

### Bash

1. I'm a pretty big fan of both [Bash-it](https://github.com/Bash-it/bash-it) and [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), and have been using both somewhat interchangeably lately. Despite a few missing/broken items, they both work pretty well on WSL:)  Install Bash-it with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bash-it/bash-it/master/install.sh)"` 

### Zsh

1. Install oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
1. You may also want to try out the excellent powerlevel9k theme.
  * First, `mkdir ~/src` then `git clone https://github.com/bhilburn/powerlevel9k.git ~/src/powerlevel9k`
  * Create a symlink with `ln -s ~/src/powerlevel9k/powerlevel9k.zsh-theme ~/.oh-my-zsh/custom/themes/powerlevel9k.zsh-theme`.

*Note that for older Windows builds (I believe this may be fixed on recent builds but haven't confirmed this yet...), currently running a special theme in *either Bash-it or oh-my-zsh*, i.e. powerline-multiline for Bash-it or powerlevel9k for oh-my-zsh, slows things down pretty intolerably... - If you're on an older build, I'd recommend limiting your customizations if speed is important to you.


### Homesick

I'm also a big fan of managing my dotfiles across different distributions with [Homesick](https://github.com/technicalpickles/homesick). While more or less a git wrapper abstracting a subset of core functions and mapping these to a set of reasonable conventions for managing user-specific configuration files (aka "dotfiles" or "castles" in Homesick parlance), I was initially pretty skeptical as to the relative appeal in using such a seemingly redundant, "travel-sized, git translator/symlink-er" for essentially the same/similar task I'd been fine with having plain 'ol git handle up to this point. 

I was however immediately struck by the economy offered by this "less is more" approach once I experienced the intuitive, "baked-in" ease to logically creating/maintaining my "castles", and "orchestrating" these according to simple criteria such as distribution or environment. Things like cross-platform maintenance/duplication/refactoring of installation scripts/makefiles or hooks, rebasing or resolving conflicts - much less likely to enter the problem space in the context of such limited distribution, are essentially handled by Homesick - by not handling them at all; effectively enforcing a simple boundary in this absence, and underscoring the "right-sized" use case for this tool (of course git is always right there waiting, doing the real work behind the scenes should you need to access its power directly..). I now consider it an indispensible tool in maintaining my configuratons, and am happy to recommend it as an alternative to managing the complexities typical of other approaches. To install it:
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

***Update*** - I've since moved on from YCM, and am now using [vim-mucomplete](https://github.com/lifepillar/vim-mucomplete) for (fast!) tab-based code-completion and [vim-polyglot](https://github.com/sheerun/vim-polyglot) for syntax highlighting - a combo I've been extremely happy with! :) Also, if you are wanting to build Vim 8 from source, **have a look at this gist [here](https://gist.github.com/rodtreweek/894f02a23bbc7e3691fa1a0f954e3a40)**, which uses [checkinstall](https://debian-administration.org/article/147/Installing_packages_from_source_code_with_checkinstall) and **the [amazing fpm](https://github.com/jordansissel/fpm) package builder** to first create a .deb package, then safely/sanely install it :)

#### Fonts

I've also included a .fonts directory that contains a number of fonts I've found useful. You might also be interested in using a patched Inconsalata Awesome font for better terminal compatibility with vim-airline, or you might be interested in having a look at what's offered here: https://github.com/powerline/fonts .

1. Download and install the Inconsolata Awesome patched font from here:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/change_font_in_conemu.gif" height="450">

Frankly, I am still finding the adjustment to using something other than iTerm2 chief among my challenges in establishing a reasonable dev workflow on Windows.  For example, I was a bit frustrated to learn that there is no real WSL equivalent to using `"*y` within Vim on a Mac to copy to the system clipboard, then pasting *without restriction, system-wide* with `command + v`. After literally hours of experimenting, and with each suggested workaround ~featuring the same/similarly cumbersome layer of abstraction, (aka "Do I *really* need to setup an X server for this??")~ Note: *This isn't abstraction. It's really a natural boundary between two distinct operating systems. In trying to get any form of seamless copy/paste behavior to happen between the two (or perhaps three, if we're talking about ssh'ing to a remote host...), you're essentially going to have to build a bridge between the clipboard on one OS to the other, and translate the corresponding registers between these distinct buffers. Obviously, on a Mac your only really dealing with a single OS/clipboard buffer so this is more straightforward. Soooo the answer is "Yes, you'll probably need to install an X server of some sort if you want to share a clipboard b/w Linux and Windows - even when they reside within the same host."*). I finally threw in the towel ~, opting for the clunky `L shift + mouse select`, or~ for larger copy selections, a `cat <filename>`, then selecting the text with the mouse/touchpad, and `ctrl + c`, `ctrl + v` respectively to copy/paste ~, which has made me pretty tired of having to constantly type `:set nonu` in vim~.

**Update:** My ConEmu, vim-related copy/paste angst has been substantially diminished upon discovery of this simple checkbox in  **Settings --> Keys & Macro --> Mark/Copy:**

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/conemu-vim-text-select.gif" height="450">

While I don't *love* the considerable amount of trailing whitespace that this captures, or ~(despite what seems to be advertised in the ConEmu config options),~ the inability to reasonably deal with line-wrapping (**note:** again, this is really less an issue with ConEmu, and more to do with crossing the inherent boundary b/w OS's as mentioned above...) , this still makes me **a lot** happier now that I don't have to turn off line numbering, or constantly remove leading white space when pasting - for example, into this readme here on Github. :)

**Update:** I've been able to work around the trailing/leading whitespace issue as well as identify/reduce spaces before a tab by adding a few entries to my .vimrc.settings file:
```
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred
```
- Added to the `AUTOGROUPS` section under `augroup configgroup`, and then under the `SEARCHING` section:
```
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/
``` 
- Which highlights all whitespace in dark red, then:
```
" With the following mapping a user can press F5 to delete all trailing
" whitespace. The variable _s is used to save and restore the last search
" pattern register (so next time the user presses n they will continue their
" last search), and :nohl is used to switch off search highlighting (so
" trailing spaces will not be highlighted while the user types). The e flag is
" used in the substitute command so no error is shown if trailing whitespace
" is not found. Unlike before, the substitution text must be specified in
" order to use the required flag.
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
```
 - Which allows you to press the F5 key to remove all the useless whitespace in your file like so:
 
 
 <img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/whitespace_removal.gif" height="450">

Again, not *ideal*, but it at least provides some form of remedy without having to install/configure another "proxy" layer to translate various registers, and logically handle shared clipboard buffers between what again are essentially two distinct OS's, using different registers for their copy/paste behavior (note: you may have to hit the `Esc` key in order to get it to "let go"  of the text you have mouse highlighted/selected, subsequently passing it along to the clipboard buffer and `ctrl-v` pasting).

I've also configured `F2` to toggle `:set paste`, allowing for quick and precictable `ctrl-v` behavior (make sure you have also set the "multiline paste" option for ctrl-v in the settings for ConEmu...):
```
" Press F2 to toggle set paste:
set pastetoggle=<F2>
```

#### SSH on WSL
I've found that using SSH in the familiar Mac/CentOS way can be a bit problematic to duplicate on WSL. I've had issues where after I'd gotten what I thought was a reasonable handle on things, only to suddenly be confronted with a "host key verification failed" message, when certainly nothing obvious had changed in terms of the host key I was using, permissions on any presumably relevant files, hostnames or ip addresses. Even removing individual entries from the `known_hosts` file, followed later by removing *everything*, then finally deleting the file itself and rebooting the machine I was never prompted in the usual/expected way to re-add the host key. I finally had to do the following to force host-key prompting, and re-establish ssh connectivy to my remote host:
```
$ ssh -o StrictHostKeyChecking=no <your_user>@remote_host uptime
```
I actually created an alias for this called `fixssh` in my .aliases file, since I expect the problem to return at some point.

SSH port forwarding/tunneling also seems pretty broken on WSL (at the very least it doesn't seem able to integrate with any real mechanism for name to number resolution, i.e. simply reading the contents of `/etc/hosts` doesn't seem to happen, meaning that you will need to use ip addresses instead of hostnames, including `127.0.0.1` instead of `localhost`). Any attempt at creating an alias/function for this purpose will likely require the use of sudo/sudo -E preceding any commands specific to "privileged ports". In fact, I was never *really* able to get this to work natively on WSL - and perhaps collaterly why I started seeing the host key verification failures mentioned above - so you might be better served by using a native Windows app like PuTTY to accomplish this (I can report that this works quite well, if a little less intuitively in terms of initial setup than I expected...). I won't document it here, but be on the lookout for another setup guide here on Github featuring my transparent, muti-hop solution featuring ConEmu/PuTTY/Pageant and oh-my-zsh plugins to create a session "index" for several different types of encrypted tunnels/port mappings :) 

## Another quick note on sudo/su/root...

Since I'm constantly forgetting how these differ, and I suspect I'm not the only one who could use a decent reminder:


|   Command     |     HOME=/root     |     Uses root's PATH       | Corrupted by user's env vars |
| :-----------: | :----------------: | :------------------------: | :--------------------------: |
| `sudo -i`       |         Y          |      Y (#2 below)          |            **N**             |
| `sudo -s`       |         N          |      Y (#2 below)          |              Y               |
| `sudo bash`     |         N          |      Y (#2 below)          |              Y               |
| `sudo su`       |         Y          |      N (#1 below)          |              Y               |


1. PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games probably set by /etc/environment
1. PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin

In short, you probably want `sudo -i` most of the time - or the exact opposite (i.e. take all your environment variables with you) which is `sudo -E`.

## Additional/Optional items...

### Colors

1. Some themes I found for ConEmu! https://github.com/joonro/ConEmu-Color-Themes
1. Gruvbox color scheme for ConEmu: https://gist.github.com/circleous/92c74d284db392a950d64a2b368517a1
1. Solarized-dark color scheme for ConEmu: https://github.com/mattcan/solarized-gedit/blob/master/solarized-dark.xml

### Boxstarter

Definitely check out Boxstarter [here](http://boxstarter.org/InstallBoxstarter). Install it with [chocalatey](https://chocolatey.org/), the awesome package manager for Windows!  Here are some links to a few gists for use with Boxstarter:
* <https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f>
* <https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9>

### Install GVM (Go Version Manager)
1. Github repo (and basic instructions) are available [here](https://github.com/moovweb/gvm). First, run the installer with:
- `zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)` - or if you're using bash as your shell, substitute `bash` for `zsh`.
2. I had to also install the following dependencies:
```
sudo apt-get install binutils bison gcc make
```
3. Before you'll be able to install and use more recent golang versions, you'll first need to "bootstrap" gvm by installing, then using go1.4:
- `gvm install go1.4`
- `gvm use go1.4`
4. Then, you can do a `gvm listall` to show all versions up to the most recent.
- For example, install version go1.9.1 with:
- `gvm install go1.9.1`
- Upon completion, it should display:
```
Installing go1.9.1...
 * Compiling...
go1.9.1 successfully installed!
```
5. You will now be able to swiftly and easily switch among different golang versions :)

### Install [pyenv](https://github.com/pyenv/pyenv)
1. First, you'll probably need to install this stuff (so that things like bzip2 and sqlite work correctly):
```
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev
```
2. Install pyenv with:
```
zsh < <(curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer)
```
or:
```
bash < <(curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer)
```
3. Add this to your .zshrc/.bash_profile, etc.:
```
# Load pyenv automatically by adding                
                                           
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"                     
eval "$(pyenv virtualenv-init -)"      
```
4. You may need to remove these three lines from your .bashrc:
```
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```
5. Update pyenv:
```
pyenv update
```
6. Install some pythons:
```
# You can list available versions with:
pyenv install -l
# Then install with:
pyenv install 3.5.2
```
7. Once you have installed the versions of python you want, have a look at the docs here: https://github.com/pyenv/pyenv#choosing-the-python-version . In a nutshell, you'll need to use the `pyenv local` and `pyenv global` commands to set which versions of python you will want available to different projects.


### Blogs

Here are a few other blog posts I've also found helpful:

* [Dariusz Parys's dev setup](https://medium.com/@dariuszparys/my-windows-10-dev-setup-67d7aecb63a6)
* [David Tran's setup guide](https://davidtranscend.com/blog/windows-terminal-workflow-guide)
* [Andreas Johansson's terminal setup guide](https://medium.com/@Andreas_cmj/how-to-setup-a-nice-looking-terminal-with-wsl-in-windows-10-creators-update-2b468ed7c326)
* [(Microsoft's) Brian Ketelsen offers a look at his dev setup here](https://brianketelsen.com/my-cross-platform-dev-setup-on-surface-laptop/) and also [here](https://brianketelsen.com/i3-windows/)
* [Mike Lindegarde's powerlevel9k theme setup on Windows 10](http://mikelindegarde.com/post/2016/03/10/feeling-like-a-real-developer)
* [Rushi Agrawal's guide to Tmux copy/pasting](http://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/)
* [Scott Hanselman's setup](https://www.hanselman.com/blog/SettingUpAShinyDevelopmentEnvironmentWithinLinuxOnWindows10.aspx)

I'll be continuing to frequently add/remove/edit items contained within this project (perhaps until I author a proper blog post elsewhere, and make what's here a bit more conventional, i.e. much lighter on editorial, heavier emphasis on clear/concise list of installation/configuration steps ;)
