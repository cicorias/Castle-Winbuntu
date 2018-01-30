<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/castle_winbuntu_welcome.png" height="250" alt="castle-winbuntu"> [![Travis CI](https://travis-ci.org/rodtreweek/Castle-Winbuntu.svg?branch=master)](https://travis-ci.org/rodtreweek/Castle-Winbuntu)
---

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/xfce4_powerlevel9k_win10.PNG" height="450">

## Welcome!

This is my [Homesick](https://github.com/technicalpickles/homesick) Castle intended for use on the Windows Subsystem for Linux (aka "WSL", or Bash/Ubuntu on Windows).

If your search for guidance on setting up a reasonable dev environment on WSL has lead you here, I hope that through offering this fairly opinionated, occassionally solipsistic, yet well-intentioned collection of observations, example configurations/dotfiles, and earnest attempt at thoroughly detailing my experience interacting with Microsoft's optionally enabled Windows Subsystem for Linux (WSL) you may find something useful here :)

I also leverage the deployable ease of Homesick in distributing and managing my configuration files, which I've also included as an example Homesick "castle" which you are free to clone/download (see the instructions at the end of this readme), intended as a meaningful way to expand the descriptive dimensions of the discussion that follows. However, the usual "ymmv", "No warranty either express or implied", "Use of this repo may totally break your sh\*t" - rules governing personal responsibility most definitely apply here, and you should certainly always be weighing the associated risks of hastily cloning some random dotfiles project into your environment off Github (or really in introducing any new code obtained from anywhere on the Internet into your organization or personal workflow) :)

:watch: [TL;DR](#tldr---the-meat-and-potatoes-of-deploying-the-dotfiles) :fast_forward: :checkered_flag:

But first, before you so eagerly throw your support behind Microsoft's (at least in the opinion of this writer, *extremely welcome*) efforts to be much more open-source interested/inclusive, I'd recommend as initial preparation reading [this excellent blog post](https://blog.jessfraz.com/post/windows-for-linux-nerds/) from former Docker/Google-Engineer-turned-core-member-of-Microsoft's WSL/Container Development Team, [Jessie Frazelle](http://redmonk.com/jgovernor/2017/09/06/on-hiring-jessie-frazelle-microsofts-developer-advocacy-hot-streak-continues/) discussing the nuts and bolts of WSL.


## Additional background and some observations...

It should also be noted that prior to getting *too* precious about the idea of using WSL exclusively as your seamless "personal development-workflow-*asis*", you'll want to be aware that WSL is *highly* Windows build-dependent - meaning that certain things you might expect to "just work" in Ubuntu/Bash *may only be supported in more recent builds, or perhaps offered exclusively through the Windows Insider Program*.

In fact, after spending *a lot* of time in pretty rigorous comparison over the last several months - *and if your build-version would seem to support it* - I might even suggest skipping the rest of this guide, and heading straight over to https://blog.ropnop.com/configuring-a-pretty-and-usable-terminal-emulator-for-wsl - and configuring WSL along similarly X-server-based lines as opposed to the "ConEmu-centric" approach roughly-outlined here (*Note:* You may additionally need to do as instructed [here](https://www.reddit.com/r/Windows10/comments/4rsmzp/bash_on_windows_getting_dbus_and_x_server_working/?st=jbilzojq&sh=30f063d5) in order to get your X-server/Linux terminal app to work properly under WSL.).

**Update**: I've also discovered [tmuxinator](https://fabianfranke.de/2013/11/19/use-tmuxinator-to-recreate-tmux-panes-and-windows/) which has reduced the whispered profanity punctuating each VcXsrv crash substantially as well.

**Update**: I've now ditched VcXsrv in favor of [MobaXterm](https://mobaxterm.mobatek.net/) --which is working out *much* better for me (in fact, I've yet to see a single crash...). It has however been quite a bit more difficult for me to hack out a powershell script/shortcut that starts things up in an orderly manner, predictably launching an xfce4-terminal (although I have something working, it's *far* from what I would consider sufficient...essentially I'm adding an arbitrary amount of delay through the use of a "sleep" command so as to negotiate a pretty convolluted "relay" b/w MobaXterm, ConEmu, xfce4-terminal, and tmux/tmuxinator...).

However, I'm definitely more comfortable recommending this sort of approach now than in the past where I naively considered any use of an X-server as contadicting some vaguely "minimalist" orthodoxy I thought I was honoring by restricting my terminal selection to Windows-native only. Even considering the awkward and fairly disruptive VcXsrv crashes (which seems to happen when I drag the terminal window around just a bit too much) this is hands down a **much** more sustainable way to get things done than trying to twist a native-Windows app into the pretzel-shaped approximation of what has become my dimming recollection of a merely sufficient Mac/iTerm2 workflow. I will surely be either creating another Homesick castle specific to this approach, or at least in the short term adding some additional commentary here as to how to accomplish the initial setup for this type of configuration :)

Since I believe I've now spent enough time experimenting with WSL to form a reasonably credible opinion - perhaps even earning the right to express this editorially - and given just how crucial I feel it is to minimizing any substantial impact to personal productivity/expected rate of contribution when transitioning to a Windows-based workflow, *I'll just come right out and say that:* **There are currently no [terminal applications for Windows](https://raw.githubusercontent.com/rodtreweek/i/master/ansible/term_probs.gif) that can compete with those offered natively for Linux or to the (truly excellent) iTerm2 for Mac**.

The friction resulting from such a limited number of comparatively imprecise options would seem to abrasively persist well into a project's term, corrosively inhibiting collaborative speed and iterative improvement based on the character or requirements for a particular project (i.e. golang/node.js projects would seem to benefit significantly less from an exclusively Windows-native development workflow), and by incremental extension more likely to chafe any credible "bottom-up" attempt at process-engineering CI/CD, or any serious initiatives aimed at "Digital Transformation".

### Check your build-version...

Yes, I'll say it again that your Windows build version will be the *single-most important factor* in determining which path your WSL configuration is likely to take. Unfortunately for me (and perhaps those continuing to read), the full realization of this uncomfortable fact arrived much less swiftly than I would have preferred when I began configuring my environment for golang development and was immediately pummelled by `go build <command-line-arguments>: read |0: interrupted system call` errors that would appear randomly regardless of version, then overlap with frequent (and ultimately insurmountable) Vim code-completion plugin errors - or more recently while trying to go the "VcXsrv/Terminator" route as suggested in the previous link when I was halted abruptly (and permanently) by continual ` Client failed to connect to the D-BUS daemon:` - errors.

If you're on an earlier build-version (prior to 15046, aka the "Windows Creator Update"), aren't able to upgrade for reasons outside your control, and are hitting some of these same snags as described above, then you may want to keep reading :)

### Again, with the build vesion...

You can easily check your Windows build version by simply hitting the Windows key on your keyboard, typing `winver`, then checking the version against [the release notes here](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes).

Generally speaking, if you are planning to write golang code in WSL, you'll likely want to be on at least [build 14905](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes#build-14905) which supports restartable system calls (thus avoiding the dreaded `read |0: interrupted system call` errors mentioned above, and of which a thorough discussion can be found [here](https://github.com/Microsoft/BashOnWindows/issues/1198)).

### Choosing a terminal application...

~Presently, I'm using~ Up until very recently I had been exclusively using [ConEmu](https://conemu.github.io) as my terminal application, as it felt (to me) the most similiar to iTerm2 - a Mac-specific mainstay that to say the least, I had grown quite fond of.  Having now tried Hyper.js, wsltty and a few others (the names of which I'm now forgetting), ConEmu - while far from a perfect replacement for iTerm2 - emerged as the most stable, configurable, and fully-featured of those I had tried. It also offers tabbed-sessions, ~which I can't really live without~ which up to this point had been a firm requirement for me, even as I warmed slightly to the exclusive use of tmux to boundary my sessions. However, as noted earlier I'm now mainly using the terminal application available as part of xfce4 which requires the use of VcXsrc, which perhaps not surprisingly has also had its fair share problems (specifically, if having to re-establish your sessions and/or reconfigure all your panes/windows on average a couple of times a week due to VcXsrc crashes doesn't feel like an acceptable trade-off to you, then I'd actually recommend that you stick with ConEmu...). 

Whichever terminal application you choose, you will want it configured to run as an administrator - which I quickly learned when I initially tried to use the `ping` command, and got a "Permission denied" error.  To configure this in ConEmu, open up Settings --> Startup --> Tasks, and add the `-new_consule:a` flag to your executable string for your Bash task so that it looks like `%windir%\system32\bash.exe ~ -new_console:a` when you're finished. 

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/conemu_bash_admin.png" height="450">

Click `Save settings` and Bash should no longer complain about permissions/privileges.

**Update:** I'm now recalling more completely why tabbed-sessions had previously held such appeal for me. While a local tmux config is great for maintaining *local* session boundaries, even if you are careful to detach from them, they are still tethered to a *local* process, -- meaning that the now-in-progress compile of Vim 8 you just kicked-off on a remote host isn't going to withstand the incoming forced-reboot naturally triggered by Windows Update minutes later ;) 

To avoid this potential calamity you *still* need some mechanism by which to automatically start/create or re-attach to existing sessions on remote hosts (and subsequently boundary these sessions).  This is where tabbed-sessions is particulary useful, since each remote connection can then be represented in *it's own tab* - and by logical extension much more intuitively mapped in a 1-to-1 manner to *its own individual tmux session - initiated and maintained on the remote host*.

In the past, since it was common that I might be connected to several remote systems at any given time (typically using `sudo -i` or `sudo su -`), it was extremely useful (I might even say it was a requirement...) for me to maintain several tabbed-sessions each of which was bound to some conditional logic in both my local and remote .tmux.conf files and aliased to the `autossh` command to establish what was essentially a "Close the lid on laptop. Drive home. Open lid on laptop. Trigger vpn connection - now wait for sessions to be restored in each tab..." - method of persistance (for example, similar to that offered [here](https://github.com/PinkPosixPXE/iterm-auto-ssh)). While ssh "automation" at this level may not be of interest to everyone, and certainly should be balanced against any potential security implications (for example, at a minimum great care should be taken in preventing ssh-agent process-sprawl through something like some cleanup-scripting in a .bash.logout file, or the excellent oh-my-zsh forward-agent plugin, etc.), it's hard not to appreciate the friction-free convenience of this configuration  - especially at 3am when the increasing frequency of CRITICAL alerts has converged to form a singular, uninterrupted tone - announcing the arrival of a 48-hour-work-marathon ;)


### Upgrading WSL's Ubuntu to 16.04


One additional observation that I should note is that [while simply removing and reinstalling WSL](https://www.howtogeek.com/278152/how-to-update-the-windows-bash-shell/) is *supposed to* upgrade you from Ubuntu 14.04 to 16.04, this was not true for me, despite what I was pretty sure (at the time) was a supported build (it simply hung indefinitely at the command line, even after I fully uninstalled, rebooted, then repeated the lxrun install..I finally had to manually kill it - and in the end was *still* left with an unaltered version of 14.04).

However, not one to acquiesce so easily to such abruptly suspended progress, and now enticed perhaps a bit too unreasonably by the "waxy-shine" of the now "forbidden fruit" of Ubuntu 16.04 to remember giving it at least a quick rinse to dillute any caustic pesticides or cosmetic produce varnishes, I had to spend a fair bit of time mitigating the upgrade "indigestion" in WSL.

Here's what I needed to do to get everything upgraded more or less successfully to 16.04:


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
**Update** Note: you should instead use the following set of commands when upgrading, so as to not need to reinstall packages:
```
$ sudo -S apt-mark hold procps strace sudo
$ sudo -S env RELEASE_UPGRADER_NO_SCREEN=1 do-release-upgrade
```

I've since come to understand that 16.04 is technically not supported on pre-"Creator" builds, so I should probably just state for the record here that for those thinking of rolling the dice, upgrading *may invite a number of other unexpected "guests to the party* who then refuse to leave and break some of your fancy stuff :( The point here is that you should be reasonably clear on what problem you are looking to solve by upgrading to 16.04 and either pretty sure it contains the "fix", or are at least willing to accept the risk. My decision to upgrade wasn't particularly well-articulated, but rather prompted mainly by a pair of *really* frustrating issues where i was pretty willing to take my chances experimenting, but that I *thought* would be resolved by upgrading to Ubuntu 16.04:
* Several of my Vim plugins didn't work with the stock version of Vim that ships with Ubuntu 14.04 (In the end, I actually wound up just building Vim 8 from source due to dependency problems encountered with the Vim YouCompleteMe plugin that persisted even into 16.04).
* The routine difficulty I was having with getting sudo to work predictably/reliably, i.e. `sudo apt-get install` would typically hang, and it seemed like I was constantly having to exit my shell to perform trivial tasks as root.

While upgrading was perhaps the right decision for me ultimately, it really didn't resolve either of the issues I'd sought to remedy initially; the YCM plugin still complained about the version of Vim, and `sudo apt-get install` now seemed even more busted than ever - having added a "decorative" new `sudo: no tty present and no askpass program specified` - error to it's limited output. I finally resolved this by downgrading several packages (-- see the `wget`, `dpkg -i` commands and `/dev/tty` permissions changes noted above...), however each time I was subsequently tempted to run `sudo apt-get update`, I reflexively hesitated, - wondering if doing so might upset the seemingly fragile balance I'd worked to achieve (which, yes, continues to be a problem for me on my build). 

In retrospect these issues were again highly build/environment specific, (and I'll admit ~due in part to my misunderstanding of how sudo/su actually works with environment variables in WSL~ *how sudo really just works in general* - see my table [below](#another-quick-note-on-sudo)), and would seem comparatively rare, especially for those who have already carefully checked their build version for any surprises and are on anything other than the earliest Windows 10/WSL builds ;) In any case, since this was a much less straightforward and time-consuming process than I had anticipated, I'm including this information in case it might be useful to the similarly adventurous/impetuous :)

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

*Note that for older Windows builds (I believe this may be fixed on recent builds but haven't confirmed this yet...), currently running a large number of plugins or a special theme in *either Bash-it or oh-my-zsh*, i.e. powerline-multiline for Bash-it or powerlevel9k for oh-my-zsh, slows things down pretty intolerably... - If you're on an older build, I'd recommend choosing a minimal theme (I'm currently pretty happy with the oh-my-zsh "ys" theme..) and limiting your customizations if speed is important to you.


### Homesick

I'm also a big fan of managing my dotfiles across different distributions with [Homesick](https://github.com/technicalpickles/homesick). While more or less a git wrapper abstracting a subset of core functions and mapping these to a set of reasonable conventions for managing user-specific configuration files (aka "dotfiles" or "castles" in Homesick parlance), I was initially pretty skeptical as to the relative appeal in using such a seemingly redundant, "travel-sized, git translator/symlink-er" for essentially the same/similar task I'd been fine with having plain 'ol git handle up to this point. 

I was however immediately struck by the economical "less is more" approach offered by Homesick once I got a rhythm for its intuitive, "baked-in" ease in creating my "castles", and logical maintenance of these as git repos organized according to simple criteria such as distribution or environment. Things like cross-platform portability, reconciling conflicts, refactoring configuration management/installation scripts, authoring/updating detailed Makefiles, configuring pre/post-deployment hooks, cherry-picking commits or routine rebasing - much less likely to enter the problem space in the context of such limited distribution - are essentially handled by Homesick by not handling them at all; effectively enforcing a simple boundary in this absence, and underscoring the "right-sized" use case for swift and flexible personal workflow management and version control (of course git is always right there waiting, doing the "real work" behind the scenes should you need to access its power directly..). I now consider Homesick an indispensible tool in maintaining my configuratons, and am happy to recommend it as an alternative to the cumbersome complexities often typical of other approaches. To install it:
  1. You'll first need to install ruby, then `gem install homesick`
  1. Clone this castle with `homesick clone rodtreweek/castle-winbuntu`
  1. Create the symlinks with `homesick link castle-winbuntu`

### Vim plugins

I love, love, love vim-plug. You will too. I promise :)
https://github.com/junegunn/vim-plug

1. Vim-plug Install: 
`curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
1. Add a vim-plug section to your ~/.vimrc (or ~/.config/nvim/init.vim for Neovim). Complete instructions can be found [here](https://github.com/junegunn/vim-plug#usage), but to summarize:
1. Begin the section with `call plug#begin()`
1. List the plugins with `Plug` commands, for example:
    ```
    " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
     Plug 'junegunn/vim-easy-align'
     ```
1. End with `call plug#end()` which updates `&runtimepath` and initializes plugin system
    - This also automatically executes `filetype plugin indent on` and `syntax enable`.
    - You can however revert these settings after the call. e.g. `filetype indent off`, `syntax off`, etc.
1. Reload .vimrc and type `:PlugInstall` from within Vim to install plugins.

1. ~Setting up YouCompleteMe natively to support code-completion in WSL is unfortunately still a WIP for me, and~ I'd been largely pretty blown away by YCM when I first encountered it a couple of years back, and it still remains one of my favorite Vim plugins - when it can be made to work correctly/predictably. The lenghthy list of dependencies and fairly complicated sequence of installation/configuration steps often idiosyncratic for whichever programming language(s) you may need it to support, already long and arduous on a Mac, was a significantly lengthier and perplexing ordeal on WSL - and ultimately a failed experiment for me:( Although this again appears to be mainly due to the limitations of my Windows/WSL build, but the dated versions of Vim packaged with both Ubuntu Trusty and Xenial certainly haven't helped matters, nor am I eager to recommend any of the sparse documentation/resources I was able to find (these just gave me false-hope beyond any reasonable effort in continuing). If however you may still want to give it a shot, you will first need to install Vim 8 (which is generally preferable to 7 anyway) following the instructions here to build it from source: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source  - *Note:* be careful to heed the warning for python 2 vs. 3 when building your config, as there are issues when attempting to use both...).

***Update*** - I've since moved on from YCM, and am now using [vim-mucomplete](https://github.com/lifepillar/vim-mucomplete) for (fast!) tab-based code-completion and [vim-polyglot](https://github.com/sheerun/vim-polyglot) for syntax highlighting - a combo I've been extremely happy with :) Also, if you still may want to build Vim 8 from source, **have a look at this gist [here](https://gist.github.com/rodtreweek/894f02a23bbc7e3691fa1a0f954e3a40)**, which uses [checkinstall](https://debian-administration.org/article/147/Installing_packages_from_source_code_with_checkinstall) and **the [amazing fpm](https://github.com/jordansissel/fpm) package builder** to first create a .deb package, then safely/sanely install it :)

#### Fonts

I've also included a .fonts directory that contains a number of fonts I've found useful. You might also be interested in using a patched Inconsalata Awesome font for better terminal compatibility with vim-airline, or you might be interested in having a look at what's offered here: https://github.com/powerline/fonts .

1. Download and install the Inconsolata Awesome patched font from here:
  * <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/change_font_in_conemu.gif" height="450">

~Frankly, I am still finding the adjustment to using something other than iTerm2 chief among my challenges in establishing a reasonable dev workflow on Windows.~ My appreciation for iTerm2 has only deepened while I have sought to replace it with something even fractionally suitable. In fact, there doesn't seem to be any real WSL equivalent to using `shift + v` to highlight rows and then `"*y` to copy to the system buffer as I had routinely done in Vim on my Mac - then pasting freely *without restriction, system-wide* with `command + v`. 

After literally hours of experimenting, and with each suggested workaround ~featuring the same/similarly cumbersome layer of abstraction, (aka "Do I *really* need to setup an X server for this??")~ Note: *While it doesn't make it any less of a pain-point, for the sake of fairness and acccuracy, I should offer the correction that this isn't really "abstraction". It's really just a feature of dealing with the natural boundary between what are really two distinct operating systems.* 

In trying to get any form of "seamless" copy/paste behavior to happen between the two (or perhaps even three, if we're talking about ssh'ing to a remote host...) OS's, you're essentially going to have to build a "bridge" between the clipboard on one OS to the other(s), and translate the corresponding registers between these distinct buffers. Obviously, on a Mac you're only really dealing with a single OS/clipboard buffer - so this is a much more straightforward/transparent operation - and easily taken for granted when using terminal applications like the built-in Terminal or iTerm2 on a Mac. 

Soooo the short answer is: *"Yes (at a minimum), you'll need to install an X-server of some sort (xming/VcXsrv) if you want to share a clipboard b/w Linux and Windows - even when one (WSL) would appear to reside on the same host OS."*. 

Having now travelled down every available avenue with my build version, I finally threw in the towel and am trying out VcXsrv (additionally requiring the installation of **a bunch** of other stuff to satisfy various dependencies for first Terminator, then xfce4 respectively, i.e. the (huge) ubuntu-gnome-desktop package which seemed necessary to fill various other "gaps" in my build version) - but if you do decide to go this route make sure you have enough disk space...

 I will say however that my ConEmu, vim-related copy/paste angst was substantially diminished upon discovery of this simple checkbox in  **Settings --> Keys & Macro --> Mark/Copy:** 
<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/conemu-vim-text-select.gif" height="450">

- then just selecting the text with the mouse/touchpad, or for larger copy selections, first doing a `cat <filename>`, then selecting the text, and `ctrl-c`, `ctrl-v` respectively to copy/paste.

While I don't *love* the *considerable* amount of trailing whitespace that this captures, or the inability to reasonably deal with line-wrapping (**note:** again, this is really less an issue with ConEmu, and more to do with crossing the inherent boundary b/w OS's as mentioned above...) , this still made me **a lot** happier than having to first turn off line numbering, or constantly remove leading white space when pasting, for example into this readme here on Github. :)

**Update:** I was able to work around the trailing/leading whitespace issue as well as identify/reduce spaces before a tab by adding a few entries to my .vimrc.settings file:
```
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred
```
- Added to the `AUTOGROUPS` section under `augroup configgroup`, and then under the `SEARCHING` section:
```
" Show trailing whitespace and spaces before a tab:
match ExtraWhitespace /\s\+$\| \+\ze\t/
``` 
- Which highlights all whitespace in dark red, then by adding this:
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
 - I'm able to press the F5 key to remove all the useless whitespace in a file like so:
 
 
 <img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/whitespace_removal.gif" height="450">
**Note:** you may have to hit the `Esc` key in order to get it to "let go"  of the text you have mouse highlighted/selected, subsequently passing it along to the clipboard buffer and allowing for `ctrl-v` pasting).

Again, not *ideal*, but this method arguably offers the least complicated remedy for cleaning-up problematic whitespace which some may even find preferable to the added installation, configuration, maintainance, and additional complexity of using an X-server to "proxy" terminal connections to a shared clipboard buffer - or perhaps having to troubleshoot multiple system components when things go wrong.

Another annoyance I was committed to at least minimizing right away was the routine observation of my pasted text "cascading" in a sideways ripple, before becoming a series of steady waves crashing against the margins of my text editor - every time (which is all the time) I forget to type `:set paste`. While it hasn't improved my memory any, and the "tide" seems to come in just as frequently as it did before, I've at least configured `F2` to toggle `:set paste` - so now I only have to type `u + F2` :) (Oh, also make sure you have the "multiline paste" option set for ctrl-v in the settings for ConEmu...):
```
" Press F2 to toggle set paste:
set pastetoggle=<F2>
```

#### SSH on WSL
I've found that using SSH in the familiar Mac/CentOS way can be a bit problematic to duplicate on WSL. I've had issues where after I'd gotten what I thought was a reasonable handle on things, only to suddenly be confronted with a "host key verification failed" message, when certainly nothing obvious had changed in terms of the host key I was using, permissions on any presumably relevant files, hostnames or ip addresses. Even removing individual entries from the `known_hosts` file, followed later by removing *everything*, then finally deleting the file itself and rebooting the machine I was never prompted in the usual/expected way to re-add the host key. I finally had to do the following to force host-key prompting, and re-establish ssh connectivy to my remote host:
```
$ chmod 0666 /dev/tty
$ ssh -o StrictHostKeyChecking=no <your_user>@remote_host uptime
```

**An additional word of warning here**...You may also find (as I have just today...) that after spending an hour troubleshooting an SSH key-based authentication issue, where there was **absolutely NO discernible whitespace** in the authorized_keys file, I was *still* getting password-prompted even after *quadruple-checking all permissions*.
* Here's a tip.  If you are having difficulty authenticating via key exchange do the following:
1. On the host you are having difficulty, login via password initially.
1. Next, back-up any id_rsa/id_rsa.pub files in the .ssh directory (*warning* these will be overwritten), and generate a key pair via the usual means. `ssh-keygen -t rsa` should do fine for now. Accept all the defaults.
1. Then, use the `ssh-copy-id` command to copy the file *locally*, i.e. `ssh-copy-id -i ~/.ssh/id_rsa.pub localhost`, which should create the `authorized_keys` file if it doesn't already exist, and add your public key to it.
1. Check that you now have a ~/.ssh/authorized_keys file, and that it matches what you have in ~/.ssh/id_rsa.pub.
1.  If everything checks out, simply do `ssh localhost`, and you *should not* get password-prompted, and be logged-in straight away.If you are *still* prompted for a password, these are the main items to check:
##### **Permissions as follows:**
* `700` on *your home directory* (this is an easy one to miss, and typically only surfaces when `/etc/ssh/sshd_conf` contains the directive "StrictModes yes"...this one had me searching high and low...)
* `700` on `.ssh`
* `600` on `authorized_keys`
##### **Make sure you are either using the `ssh-copy-id` utility, or doing a `cat id_rsa.pub >> authorized_keys` from the original .pub file and NOT simply copy/pasting from Outlook, etc.**  
Even after *painstakingly* examining the output of `ssh user@host -vvvvvvvvvvvvvvvvv` for clues, I was unable to figure out where Outlook had seemingly done it's "smart" formatting on an ssh public key that an end-user had copy/pasted into an email. Unless you want to go through the unnecessary motions of checking every link in this particular chain, I'd recommend you *insist* (gently, of course) that any public keys you intend on placing on a host arrive in a "tamper-resistant" `.pub` file ;)
##### **Oh, also, as of OpenSSH 7.0 ssh-dss keys don't work anymore. 
This has apparently been the case for at least a couple years now. Oddly, I have only really found this slender "article" discussing the issue here: https://meyering.net/nuke-your-DSA-keys/ - which was written 7 years ago in 2010 - indicating the presence of an underlying vulnerability, and a *full five years before the release of OpenSSH 7.0* (released August, 2015) where DSA support was finally dropped entirely.

SSH port forwarding/tunneling also seems pretty broken on WSL (at the very least it doesn't seem able to integrate with any real mechanism for name to number resolution, i.e. the `/etc/hosts` file at times like it just gets ignored completely - or is perhaps less "authoritative" than the Windows-native "hosts" file. What this means is that you will typically need to use an ip addresses rather than the fqdn/hostname (including `127.0.0.1` instead of `localhost`) - unless resolvable by a local/internal DNS server. You will also likely need sudo privileges in order to execute any aliases/functions which may be configured to use "privileged ports" (- which are really most all of them). 

In fact, I was never *really* able to get ssh port-forwarding to work natively in WSL - and perhaps collaterly why I started seeing the host key verification failures mentioned above - so you might be better served by using a native Windows app like PuTTY to accomplish this (I can report that this works quite well, if a little less intuitively in terms of initial setup than I had expected...). ~I won't document it here, but be on the lookout for another setup guide here on Github featuring my transparent, muti-hop solution featuring ConEmu/PuTTY/Pageant and oh-my-zsh plugins to create a session "index" for several different types of encrypted tunnels/port mappings :)~ 

**Update:** I was *finally* able to get **ssh multiplexing** to work, which has *all but completely eliminated a massive number of obstacles for me*... I'd describe this particular discovery as really the Sysadmin equivalent of feeling an immediate surge of supernatural power after being bitten by some weird glowing orange spider, or a sudden shirt-shredding green pectoral enormity after having absorbed the entire radioactive payload of some oddly experimental, highly-concentrated mix of weapons-grade plutonium, fish oil supplements, wheatgrass and Human Growth Hormone :)


## Another quick note on sudo...
Since I'm constantly forgetting how these differ, and I suspect I'm not the only one who could use a decent reminder:


|   Command     |     HOME=/root     |     Uses root's PATH       | Corrupted by user's env vars |
| :-----------: | :----------------: | :------------------------: | :--------------------------: |
| `sudo -i`       |         Y          |      Y (#2 below)          |            **N**             |
| `sudo -s`       |         N          |      Y (#2 below)          |              Y               |
| `sudo bash`     |         N          |      Y (#2 below)          |              Y               |
| `sudo su`       |         Y          |      N (#1 below)          |              Y               |


1. PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games probably set by /etc/environment
1. PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin

In short, you probably want `sudo -i` most of the time (which is the same as `sudo su -`) - or it's opposite (i.e. take your environment with you) which is `sudo -E`.

## Additional/Optional items...

### Colors

1. Some themes I found for ConEmu: https://github.com/joonro/ConEmu-Color-Themes
1. Gruvbox color scheme for ConEmu: https://gist.github.com/circleous/92c74d284db392a950d64a2b368517a1
1. Solarized-dark color scheme for ConEmu: https://github.com/mattcan/solarized-gedit/blob/master/solarized-dark.xml

### Boxstarter

Definitely check out Boxstarter [here](http://boxstarter.org/InstallBoxstarter). Install it with [chocalatey](https://chocolatey.org/), the awesome package manager for Windows!  Here are some links to a few gists for use with Boxstarter:
* <https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f>
* <https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9>


### Docker for Windows

1. In addition to installing [Docker for Windows](https://www.docker.com/docker-windows) I also had to open up Powershell and run this:
```
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All
```
- which was necessary to get Hyper-V fully installed.

### Install GVM (Go Version Manager)
1. Although I ultimately didn't get very far with golang on my initial build, I have had success with it on a more recent Windows 10 build, so ymmv.
The Github repo and basic instructions are available [here](https://github.com/moovweb/gvm). 
First, run the installer with:
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
bash < <(curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer)
```
3. Add this to your .zshrc/.bash_profile, etc.:
```
# Load pyenv automatically by adding                
                                           
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"                     
eval "$(pyenv virtualenv-init -)"      
```
4. Update pyenv:
```
pyenv update
```
5. Install some pythons:
```
# You can list available versions with:
pyenv install -l
# Then install with:
pyenv install 3.5.2
```
6. Once you have installed the versions of python you want, have a look at the docs here: https://github.com/pyenv/pyenv#choosing-the-python-version . In a nutshell, you'll need to use the `pyenv local` and `pyenv global` commands to set which versions of python you will want available to different projects.


### Blogs

Here are a few other blog posts I've also found helpful:

* As I have mentioned, I'm currently trying out the xfce4 terminal app as discussed here: https://askubuntu.com/questions/827952/a-better-terminal-experience-for-windows-subsystem-for-linuxwsl - which, despite a bit of initial "noise" surrounding the somewhat clunky way I'm starting VcXsrv and the xfce4 terminal via a (probably misconfigured) Powershell shortcut, some intermittent VcXsrv crashes, and having to deal with the occassional splash of control characters salted throughout my copy/paste buffer (i.e. stuff like extraneous "200"'s, and "~"'s - sometimes "framing" Github repository url's copied by clicking the "copy to clipboard" button, etc.) this is still **much, much** more tolerable than anything else I have tried to date. Microsoft (or frankly any other enterprising/ambitious group of presumably C coders...) would seem to have a pretty significant opportunity here to introduce a real terminal application that could absolutely blow away anything currently available, and really be a suitable compliment to something like VScode - which would certainly go a long way to solidly supporting any claimed committment to developer advocacy :) I'd certainly be interested in hearing from anyone else who may have some thoughts on this (one way or the other).
* Here's the official xfce4 Terminal docs page: http://docs.xfce.org/apps/terminal/start. I'll be offering more insights as I experiment with this.
* [Dariusz Parys's dev setup](https://medium.com/@dariuszparys/my-windows-10-dev-setup-67d7aecb63a6)
* [David Tran's setup guide](https://davidtranscend.com/blog/windows-terminal-workflow-guide)
* [Andreas Johansson's terminal setup guide](https://medium.com/@Andreas_cmj/how-to-setup-a-nice-looking-terminal-with-wsl-in-windows-10-creators-update-2b468ed7c326)
* [(Microsoft's) Brian Ketelsen offers a look at his dev setup here](https://brianketelsen.com/my-cross-platform-dev-setup-on-surface-laptop/) and also [here](https://brianketelsen.com/i3-windows/)
* [Mike Lindegarde's powerlevel9k theme setup on Windows 10 using (Cygwin-variant) Babun](http://mikelindegarde.com/post/2016/03/10/feeling-like-a-real-developer) (Also contains some good info on oh-my-zsh plugin configuration).
* [Rushi Agrawal's guide to Tmux copy/pasting](http://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/)
* [Scott Hanselman's setup](https://www.hanselman.com/blog/SettingUpAShinyDevelopmentEnvironmentWithinLinuxOnWindows10.aspx)
* [Jeff Geerling's guide to using Ansible on WSL](https://www.jeffgeerling.com/blog/2017/using-ansible-through-windows-10s-subsystem-linux)
* [More fonts...](http://input.fontbureau.com/)
* Although unfortunately this hasn't worked for me yet, (see 'build version' discussion above...) I'm quite happy to endorse the approach offered by "ropnop" here: https://blog.ropnop.com/configuring-a-pretty-and-usable-terminal-emulator-for-wsl/. This approach features the installation of an X-server to facilitate the use of the Linux Terminator app.
* Fixing zsh-autocomplete auto-accept: https://jee-appy.blogspot.com/2017/06/tab-completion-is-not-working-oh-my-zsh.html

I'll be continuing to frequently add/remove/edit items contained within this project (perhaps until I author a proper blog post elsewhere, and make what's here a bit more conventional, i.e. much lighter on editorial, heavier emphasis on clear/concise list of installation/configuration steps ;)
