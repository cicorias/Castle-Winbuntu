<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/castle_winbuntu_welcome.png" height="250" alt="castle-winbuntu"> [![Travis CI](https://travis-ci.org/rodtreweek/Castle-Winbuntu.svg?branch=master)](https://travis-ci.org/rodtreweek/Castle-Winbuntu)
---

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/xfce4_powerlevel9k_win10.PNG" height="450">

## Welcome!

**Update:** If you're trying to install WSL on a work PC, make sure you check with your IT department before proceeding...it's usually a good idea to let them know what you're up to beforehand to prevent any potential misunderstandings (and may even represent an opportunity to "evangelize" the virtues of leveraging WSL organizationally..) 

Once you are clear on organizational policy, and you have *everything* required by your IT department installed and updated, install WSL by first turning on "Developer Mode" (hit the Windows key on your keyboard, then just type "developer" - which should list it as "For developer settings"...) then, using an elevated Powershell, first run: `Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux` (you may need to reboot after this step...) and then: `Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing` - which, may additionally prompt you with an "Install from store" pop-up. If you are locked on an earlier build, you might instead need to follow the instructions here: https://docs.microsoft.com/en-us/windows/wsl/install-win10#for-anniversary-update-and-creators-update-install-using-lxrun ...ok moving on...

This is my [Homesick](https://github.com/technicalpickles/homesick) Castle intended for use on the Windows Subsystem for Linux (aka "WSL", or Bash/Ubuntu on Windows).

If your search for guidance on setting up a reasonable dev environment based on WSL has lead you here, I hope that through offering this fairly opinionated (entirely my own), occassionally solipsistic, yet well-intentioned collection of observations and sample configurations I may be of service to you :)

I also leverage the deployable ease offered by Homesick in distributing and managing my configuration files, and have included an example Homesick "castle" in this repo which you are free to clone/download.

However, the usual "ymmv", "No warranty either expressed or implied", "Use of this repo may totally break your sh\*t" - rules governing personal responsibility most definitely apply here, and you should certainly always be weighing the associated risks of hastily cloning some random dotfiles project into your environment :) (you can skip to the instructions by clicking here: [TL;DR](#tldr---the-meat-and-potatoes-of-deploying-the-dotfiles) :watch: :fast_forward: :checkered_flag:
).

But first, before you so eagerly throw your support behind Microsoft's (at least in the opinion of this writer, *extremely welcome*) efforts to be much more open-source interested/inclusive, I'd recommend reading [this excellent blog post](https://blog.jessfraz.com/post/windows-for-linux-nerds/) from former Docker/Google-Engineer-turned-core-member-of-Microsoft's Container Development Team, [Jessie Frazelle](http://redmonk.com/jgovernor/2017/09/06/on-hiring-jessie-frazelle-microsofts-developer-advocacy-hot-streak-continues/) discussing the nuts and bolts of WSL.


## Additional background and some observations...

It should also be noted that prior to getting *too* precious about the idea of using WSL exclusively as your seamless "personal development-workflow-*asis*", you'll want to know that WSL is *highly* Windows build-dependent - meaning that certain things you might expect to "just work" in Ubuntu/Bash *may only be supported in more recent builds, or perhaps offered exclusively through the Windows Insider Program*.

In fact, after spending *a lot* of time in pretty rigorous comparison over the last several months - *and if your build-version would seem to support it* - I would suggest using Boxstarter/Chocolatey to install MobaXterm and using it's builtin X-server with xfce4-terminal rather than relying on something like ConEmu, etc.

During this time I also discovered [Tmuxinator](https://fabianfranke.de/2013/11/19/use-tmuxinator-to-recreate-tmux-panes-and-windows/) out of a desperate need to shield myself from the instability of VcXsrv, thus reducing the whispered profanity punctuating each terminal crash to tolerably work-safe levels :)

Here's what I (eventually) did to get things working consistently:

1. Before anything else, run: `sudo apt-get update`
1. Install Chocolatey by opening an administrative cmd.exe and running:
`@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin`
1. You're approach may differ somewhat, but personally I prefer to use Boxstarter to install a collection of core apps I use pretty frequently.  I first install it with: `choco install boxstarter -y` then open up an administrative Powershell/cmd.exe, and run: `Set-ExecutionPolicy RemoteSigned` and when prompted, typing `A` for "all". 
1. Next, I run Boxstarter against my raw gist from an admin Powershell/cmd.exe with: `Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/rodtreweek/c07a1c5624728f610c56ff84c3172f8f/raw/ae2323cc3c05f3dfa21c5503be0f5a84d19b5b96/boxstarter.ps1 -DisableReboots` - which currently installs MobaXterm 10.4.0 .
1. Then, `sudo su -` to get root (incidentally, while you're here, I'd also *highly* recommend creating a password for the root user, i.e. typing the `passwd` command and entering something reasonably complex, since this is something that's easy to miss, and ended-up being a pretty big security issue for Apple awhile back...) then: `echo "deb-src http://archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list`
1. Then: `sudo apt-get update` again.
1. Then: `sudo apt-get install xfce4-terminal`
1. Next, open up MobaXterm and click on **Sessions-->New Session** at the top.
1. A new window should open. Click on the **Shell** icon at the top of this window.
1. From the "Terminal shell" drop-down, select **Ubuntu Bash (WSL)**.
1. In the "Startup directory" field, select from the dropdown: `C:\Users\<your user>`
1. Click the "Advanced shell settings" tab and enter:
`bash -c -l "cd ~ && DISPLAY=:0 xfce4-terminal"`
1. Click the `OK` button (*ignoring the temptation* to click on the "Bookmark settings" tab and the "Create a desktop shortcut to this session" button...).
1. You should see your session listed on the left-hand side of the main MobaXterm window. Right-click the icon and (now) select "Create a desktop shortcut" to create an "Ubuntu Bash" shortcut on the desktop. This should present a pop-up with a couple checkboxes for hiding the main MobaXterm window and then exiting MobaXterm if/when this window is closed (which, while the hiding part works great, closing the terminal window still doesn't appear to terminate the main MobaXterm process...). I currently check both boxes.
1. Next, exit MobaXterm completely. Double-click the shortcut you created on your Desktop.
1. If all goes well, this should launch xfce4-terminal in a single window (without opening another window for MobaXterm itself) **Note: So far I've had no problems with this working with build 17134.228 and MobaXterm 10.4.0.0**.
1. One additional thing you will likely want to do to get copy/paste working properly between WSL and Windows: Go into the X11 server settings for MobaXterm, and change the clipboard behavior to "disable copy on select". Things should work as expected once you make this change :) 

I'm definitely more comfortable recommending this sort of approach now than in the past where I naively considered any use of an X-server as contradicting some vaguely "minimalist" orthodoxy in the spartan restriction of this to a single component. Personally, using MobaXterm to launch xfce4-terminal and Tmuxinator is just a more sustainable way for me to get things done than trying to twist what are essentially a pretty limited collection of Windows-native "ssh clients" into the pretzel-shaped approximation of my dimming recollection of a merely sufficient Mac/iTerm2 terminal solution.

Since I believe I've now spent enough time experimenting with WSL to form a reasonably credible opinion - perhaps even earning the right to express this editorially - and given just how crucial I feel it is to minimizing any substantial impact to personal productivity/expected rate of contribution when transitioning to a Windows-based workflow, *I'll just come right out and say that:* **There are currently no [terminal applications for Windows](https://raw.githubusercontent.com/rodtreweek/i/master/ansible/term_probs.gif) that can compete with those offered natively for Linux or to the (truly excellent) iTerm2 for Mac**.

I'll say it again that your Windows build version will be the *single-most important factor* in determining which path your WSL configuration is likely to take. Unfortunately for me (and perhaps those continuing to read), the full realization of this uncomfortable fact arrived much less swiftly than I would have preferred when I began configuring my environment for golang development. I was immediately pummelled by `go build <command-line-arguments>: read |0: interrupted system call` errors that would appear randomly regardless of version, and then overlap with frequent (and ultimately insurmountable) code-completion plugin errors - or more recently while trying to go the "VcXsrv/Terminator" route where I was halted abruptly (and permanently) by continual ` Client failed to connect to the D-BUS daemon:` - errors.

If you're on an earlier build-version (prior to 15046, aka the "Windows Creator Update"), aren't able to upgrade for reasons outside your control, and are hitting some of these same snags, then what follows may continue to be relevant to you :)

### Again, with the build version...

You can easily check your Windows build version by simply hitting the Windows key on your keyboard, typing `winver`, then checking the version against [the release notes here](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes).

Generally speaking, if you are planning to write golang code in WSL, you'll likely want to be on at least [build 14905](https://msdn.microsoft.com/en-us/commandline/wsl/release_notes#build-14905) which supports restartable system calls (thus avoiding the dreaded `read |0: interrupted system call` errors mentioned above, and of which a thorough discussion can be found [here](https://github.com/Microsoft/BashOnWindows/issues/1198)).

### Choosing a terminal application...

Before switching to [MobaXterm](https://mobaxterm.mobatek.net/) I had previously been using [ConEmu](https://conemu.github.io) as my terminal application, as it felt (to me) the most similiar to iTerm2 - a Mac-specific mainstay I had grown quite fond of.  Having tried Hyper.js, wsltty and a few others (the names of which I'm now forgetting), ConEmu - while far from a perfect replacement for iTerm2 - had (at the time) emerged as the most stable, configurable, and fully-featured of those I had tried. It also offered tabbed-sessions, ~which I can't really live without~ which up to that point had been a firm requirement for me, even as I warmed slightly to the exclusive use of tmux to boundary my sessions. However, as noted, it wasn't long before I tired of the issues with this particular configuration and moved on to MobaXterm and xfce4-terminal.

Should you choose to use ConEmu, you will want it configured to run as an administrator - which I quickly learned when I initially tried to use the `ping` command, and got a "Permission denied" error.  This can be configured by navigating to Settings --> Startup --> Tasks, and adding the `-new_console:a` flag to your executable string for your Bash task so that it looks like `%windir%\system32\bash.exe ~ -new_console:a` when you're finished. 

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/conemu_bash_admin.png" height="450">

Click `Save settings` and Bash should no longer complain about permissions/privileges.

I'm now recalling more completely why tabbed-sessions had previously held such appeal for me. While a local tmux config is great for maintaining *local* session boundaries, even if you are careful to detach from them, they are still tethered to a *local* process, -- meaning that the now-in-progress compile of Vim 8 you just kicked-off on a remote host isn't going to withstand the incoming forced-reboot naturally triggered by Windows Update minutes later ;) 

To avoid this potential calamity you *still* need some mechanism by which to automatically start/create or re-attach to existing sessions on remote hosts (and subsequently boundary these sessions).  This is where tabbed-sessions is particulary useful, since each remote connection can then be represented in *it's own tab* - and by logical extension much more intuitively mapped in a 1-to-1 manner to *its own individual tmux session - initiated and maintained on the remote host*.

In the past, since it was common that I might be connected to several remote systems at any given time (typically using `sudo -i` or `sudo su -`), it was extremely useful (I might even say it was a requirement...) for me to maintain several tabbed-sessions each of which was bound to some conditional logic in both my local and remote tmux.conf files and aliased to the `autossh` command to establish what was essentially a "Close the lid on laptop. Drive home. Open lid on laptop. Trigger vpn connection - now wait for sessions to be restored in each tab..." - method of persistance (for example, similar to that offered [here](https://github.com/PinkPosixPXE/iterm-auto-ssh)). While ssh "automation" at this level would seem largely replaced by what have become the underpinnings of "Infrastructure as Code" and balanced against any potential security implications (for example, at a minimum great care should be taken in preventing ssh-agent process-sprawl through something like some cleanup-scripting in a .bash.logout file, etc.), at the time I was using this method it was pretty hard not to appreciate the friction-free convenience of this configuration  - especially at 3am when the increasing frequency of CRITICAL alerts had converged to form a singular, uninterrupted tone - announcing the arrival of a 48-hour-work-marathon ;)


### Upgrading WSL's Ubuntu to 16.04 

**Note: Since the current version of WSL's Ubuntu is now at 18.x I've retained the following section mostly for historical reference/those who may be stuck on older builds.** Click [here](#tldr---the-meat-and-potatoes-of-deploying-the-dotfiles) to skip this.

One additional observation that I should note is that [while simply removing and reinstalling WSL](https://www.howtogeek.com/278152/how-to-update-the-windows-bash-shell/) is *supposed to* upgrade you from Ubuntu 14.04 to 16.04, this was not true for me, despite what I was pretty sure (at the time) was a supported build (it simply hung indefinitely at the command line, even after I fully uninstalled, rebooted, then repeated the lxrun install..I finally had to manually kill it - and in the end was *still* left with an unaltered version of 14.04).

However, not one to acquiesce so easily to such abruptly interrupted progress, and now enticed perhaps a bit unreasonably by the "forbidden fruit" of Ubuntu 16.04 without first giving it a quick rinse to remove any caustic pesticides or waxy produce varnishes, I ended-up spending a fair bit of time treating the result of some rather unpleasant "upgrade indigestion".

Here's what I needed to do to get everything upgraded more or less successfully to 16.04:

**Update** Note: you should instead use the following set of commands when upgrading, so as to not need to reinstall packages:
```
$ sudo -S apt-mark hold procps strace sudo
$ sudo -S env RELEASE_UPGRADER_NO_SCREEN=1 do-release-upgrade
```

**"Old" set of commands I needed to run:**
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
wget http://mirrors.kernel.org/ubuntu/pool/main/s/strace/strace_4.8-1ubuntu5_amd64.deb
dpkg -i sudo_1.8.9p5-1ubuntu1_amd64.deb
dpkg -i procps_3.3.9-1ubuntu2_amd64.deb
dpkg -i strace_4.8-1ubuntu5_amd64.deb
```

*Then I had to do this to get ssh to work again:*
```
chmod 0666 /dev/tty
```

I've since come to understand that 16.04 is technically unsupported on pre-"Creator" builds, so I should probably just state for the record here that for those thinking of rolling the dice, upgrading *may invite a number of other uninvited "guests" to the party who then refuse to leave, and then start breaking some of your fancy stuff* :( The point here is that you should be reasonably clear on what problem you are looking to solve by upgrading to 16.04 and pretty sure it contains either the "fix" you seek, or are at least willing to accept the risk. My decision to upgrade wasn't particularly well-articulated, prompted rather by a pair of *really* frustrating issues which had me pretty willing to take my chances in experimenting.  Here were the issues I was quite sure would be resolved by upgrading to Ubuntu 16.04:

* Several of my Vim plugins didn't work with the stock version of Vim that ships with Ubuntu 14.04 (In the end, I actually wound up just building Vim 8 from source due to dependency problems encountered with the Vim YouCompleteMe plugin that persisted even into 16.04).
* The routine difficulty I was having with getting sudo to work predictably/reliably, i.e. `sudo apt-get install` would typically hang, and it seemed like I was constantly having to exit my shell to perform trivial tasks as root (I didn't realize at the time that due to what I now believe is an environment bug, you may need to instead use `sudo -E`).

While upgrading was perhaps the right decision for me ultimately, it really didn't resolve either of the issues I'd sought to remedy initially; the YCM plugin still complained about the version of Vim, and `sudo apt-get install` now seemed even more busted than ever - having added a "decorative" new `sudo: no tty present and no askpass program specified` - error to it's limited output. I finally resolved this by downgrading several packages (-- **Note:** see the update above and notes on the `wget`, `dpkg -i` commands and `/dev/tty` permissions changes...), however each time I was subsequently tempted to run `sudo apt-get update`, I reflexively hesitated, - wondering if doing so might upset the seemingly fragile balance I'd worked to achieve ~(which, yes, continues to be a problem for me on my build)~ *again, see the Update at the top of this section for how to work around this issue by using the `-mark hold` option to sudo, etc.*. 

In retrospect these issues were again highly build/environment specific, (and I'll admit ~due in part to my misunderstanding of how sudo/su actually works with environment variables in WSL~ *how sudo really just works in general* - see my table [below](#another-quick-note-on-sudo)), and would seem comparatively rare, especially for those who have already carefully checked their build version for any surprises and are on anything other than the earliest Windows 10/WSL builds ;) In any case, since this was a much less straightforward and time-consuming process than I had anticipated, I'm including this information in case it might be useful to the similarly impetuous :)

## TL;DR - The "Meat and Potatoes" of deploying the dotfiles...

## Acknowledgements!

I'd also like to send a super-appreciative shout-out to all those who so generously share their time and effort on Github assisting others in building and shaping rapidly deployable configurations. The bulk of my dotfiles are really just a curation of extremely useful things I've either lightly iterated on, -- or simply lifted outright from others (with permission of course). Several were sourced initially from Jessie Frazelle, - who through her work with Docker, Google (and now Microsoft!), continues to impressively shape many notable innovations while promoting FOSS/OSS and remaining unfailingly generous and remarkably empathic in offering considerable guidance on a range of engineering/development issues, -- and also Nate Mccurdy from Puppet, who - in addition to providing the principal inspiration for this repo - continues to generously offer his elegantly tailored, thoughtfully maintained and rigorously "customer-prem battle-tested" code/configuration for a rapidly deployable Ruby/Puppet development workflow --- You constantly inspire me through your intelligence and generosity --- Thank you both!

Ok, I hear ya...sounds like you're hungry. Here's how to deploy:

## Shell
I'm a pretty big fan of [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), and have been using it exclusively on WSL (previously I had tried bash-it, which also worked pretty well...)  

### Bash
Install Bash-it with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Bash-it/bash-it/master/install.sh)"`

### Zsh

1. Install zsh: `sudo apt-get update; sudo apt-get install zsh`
2. Install oh-my-zsh: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
3. I'd also recommend trying out the excellent powerlevel9k theme. Install it with the following:
  * First, `mkdir ~/src` then `git clone https://github.com/bhilburn/powerlevel9k.git ~/src/powerlevel9k`
  * Create a symlink with `ln -s ~/src/powerlevel9k/powerlevel9k.zsh-theme ~/.oh-my-zsh/custom/themes/powerlevel9k.zsh-theme`
4. I'm also fond of using zplug. Install it with: `curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh`
5. **Note:** If after installing zplug and configuring your environment you begin seeing various directory "insecure" messages pop-up in WSL, execute the following: `compaudit | xargs sudo chmod -R go-w` along with: `sudo chmod 755 /usr/local/bin` to remove group/owner write permissions on these directories.

*Note that for older Windows builds (I believe this may be fixed on recent builds but haven't confirmed this yet...), currently running a large number of plugins or a special theme in *either Bash-it or oh-my-zsh*, i.e. powerline-multiline for Bash-it or powerlevel9k for oh-my-zsh, slows things down pretty intolerably... - If you're on an older build, I'd recommend choosing a minimal theme (I'm currently pretty happy with the oh-my-zsh ~"ys"~ default robby-russell theme..) and limiting your customizations if speed is important to you.

### Homesick

As noted above, I'm also a big fan of managing my dotfiles across different distributions with [Homesick](https://github.com/technicalpickles/homesick). While more or less a "git-wrapper" abstracting a core subset of typical source-control tasks to a set of reasonably intuitive conventions, Homesick still manages to differentiate itself from merely a "travel-sized, git translator/symlink-er" - by providing its themed-collection of command-line utilities similarly to git, i.e.`homesick clone`, `homesick commit`, `homesick pull`. However, it does this without the same cumbersome requirement to first `cd` into the directory under source-control to manage its contents. It's also worth noting that given the generally more user-specific and less distributed nature of managing dotfiles, the more expansive feature-set of git geared toward resolving conflicts, scaling efficiently, "cherry-picking" commits, rev-parsing, executing hooks, or sophisticated approaches to tagging/branching - can feel much less purpose-aligned and bloated when managing "personal infrastructure". In any case, it's important to remember the adjacent availability of git - always ready to be handed the "pickle jar", should a firmer "grip" be required :) 

  1. Run `sudo apt-get install ruby ruby-dev`, then change the permissions to allow write access for your user to install gems:
  ```
  sudo chmod -R go+w /var/lib/gems/2.5.0 && sudo chmod -R go+w /usr/local/bin
  ```
  2. Install Homesick with: `gem install homesick`
  3. Clone this castle with `homesick clone rodtreweek/castle-winbuntu`
  4. Create the symlinks with `homesick link castle-winbuntu`


### Vim plugins

I love, love, love vim-plug. You will too. I promise :)
https://github.com/junegunn/vim-plug

1. Vim-plug Install: 
`curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; vim +PlugInstall +qall` **Note:** to use the `.vimrc` and `.vimrc.settings` files included in this Castle you will need to be using at least Vim 8.0 ...you can build a package from source to later install from by running the script located [here](https://gist.github.com/rodtreweek/894f02a23bbc7e3691fa1a0f954e3a40)
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

1. ~Setting up YouCompleteMe natively to support code-completion in WSL is unfortunately still a WIP for me, and~ I'd been largely pretty blown away by YCM when I first encountered it a couple of years back, and it still remains one of my favorite Vim plugins - when it can be made to work correctly/predictably. The lenghthy list of dependencies and fairly complicated sequence of installation/configuration steps often idiosyncratic for whichever programming language(s) you may need it to support, already long and arduous on a Mac, was a significantly lengthier and more perplexing ordeal on WSL - and ultimately a failed experiment for me:( Although this again appears to be mainly due to the limitations of my Windows/WSL build, however the dated versions of Vim packaged with both Ubuntu Trusty and Xenial certainly haven't helped matters, nor am I eager to recommend any of the sparsely documented resources I was able to find that basically gave me false-hope in the end.). 

***Update*** - Since moving on from YCM, I've settled on using [vim-mucomplete](https://github.com/lifepillar/vim-mucomplete) for (fast!) tab-based code-completion and [vim-polyglot](https://github.com/sheerun/vim-polyglot) for syntax highlighting - a combo I've been extremely happy with :)

If however you may still want to give YCM a shot, you will first need to install Vim 8 (which I'd recommend upgrading to anyway, as it offers a number of features/improvements over Vim 7.x) following the instructions here to build it from source: https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source (it's really not that bad...although do be careful to heed the warning for python 2 vs. 3 when building your config, as there are issues when attempting to use both...) As a shortcut, **have a look at the gist I've created [here](https://gist.github.com/rodtreweek/894f02a23bbc7e3691fa1a0f954e3a40)**, which uses [checkinstall](https://debian-administration.org/article/147/Installing_packages_from_source_code_with_checkinstall) and **the [amazing fpm](https://github.com/jordansissel/fpm) package builder** to first create a .deb package, then safely/sanely install it :)

**Update** - I thought I'd take a moment here just to summarize a few things into a set of reasonable "bullet points", since I so frequently seem to jump around, rapidly lancing through prior assertions like they were line-items in an Ad-Tech "privacy policy" :) There are several things that you will likely need to configure to get things like copy/paste to work *just so* for *you* in your environment (perhaps even too many to even adequately discuss here, but I'll try...).  Here's what you will most likely want to do at a minimum:

* Install and configure *MobaXterm*. (I tried other stuff. This one works best.)
* If you use *tmux*, which I'd encourage you to try (before moving on to installing Tmuxinator as well...) if you haven't, make sure that when you change something related to display or key bindings for things like xfce4-terminal or vim in other files like `.bashrc`, `.zshrc`, or `.vimrc` that you also look at what you have in `.tmux.conf` and whether it might be necessary for you to add/change anything there so that it doesn't conflict or result in other unexpected weirdness (specifically, you may need to install and use something like `xclip` and then configure tmux to use this to work around a number of problems, i.e. the rather counterintuitively-named option `set -g set-clipboard off` - in your `.tmux.conf` which actually allows for more predictable use of the copy/paste buffer, etc....).
* *Upgrade to Vim 8* (I haven't used Neovim, which might be an option as well...I've spent quite a lot of time on my configs, so unless these are "plug 'n' play" with Neovim, I'm a bit reticent to experiment...). There are quite a lot of new features in this version, and if you intend on using the `.vimrc` and `.vimrc.settings` files included in this repo then **this version is required**. Although it's a bit of a pain to build this from source, if you are serious about using Vim as your IDE then I think it's also a bit worthwhile to get an idea as to what's contained in the source (or just go [here](https://gist.github.com/rodtreweek/894f02a23bbc7e3691fa1a0f954e3a40) :)


#### Fonts

I've also included a .fonts directory that contains a number of fonts I've found useful. You might also be interested in using a patched Inconsalata Awesome font for better terminal compatibility with vim-airline (not included - see the link below for instructions on installing this), or you might be interested in having a look at what's offered here: https://github.com/powerline/fonts .

* Download and install the Inconsolata Awesome patched font from here (not included in fonts): <https://github.com/gabrielelana/awesome-terminal-fonts/raw/patching-strategy/patched/Inconsolata%2BAwesome.ttf>
* Next, `sudo mkdir /usr/share/fonts/truetype/inconsolata-awesome/` - and copy the .ttf file you downloaded to this location.

<img src="https://raw.githubusercontent.com/rodtreweek/i/master/castle-winbuntu/change_font_in_conemu.gif" height="450">

Frankly, I am still finding the adjustment to using something other than iTerm2 chief among my challenges in establishing a reasonable dev workflow based on WSL. My appreciation for iTerm2 has only deepened while I have sought to replace it with something even fractionally as good. ~In fact, although I can now at least paste from Windows/WSL into a Vim session on a remote host - I **still** have to first annoyingly turn off line-numbering, then use tmux's rather awkward copy-mode along with some fairly lengthy tmux config settings to pipe this input to xclip and then to a shared tmux paste-buffer - and even then this only results in the capture of an often unevenly white-spaced block of arbitrarily formatted text *limited only* to that which is currently visible on the terminal screen - *then* typically requiring the additional use of Vim's `set paste` option to further limit any resulting "entropy" to an amount ideally removable through a single pass of Vim's `d`/`x`, commands. This is where poignant nostalgia begins to emmerge for the layered, complimentary warmth of iTerm2 snuggly integrated with Vim - easily selecting and capturing several rows of text (or even entire documents), swiftly "yanking" this to the local system clipboard with `"*y` - and ultimately pasting its mirror-image *system-wide - without restriction or shift key -* simply with `command + v`.~ *in newer builds, tmux v.2.6, vim 8.x, and Ubuntu 18.4 used with MobaXterm and xfce4-terminal have united to produce a pretty similar experience to what I recall with iTerm2 :)*

After literally hours of experimenting, and with each suggested workaround ~featuring the same/similarly cumbersome layer of abstraction, (aka "Do I *really* need to setup an X server for this??")~ Note: *While it doesn't make it any less of a pain-point, for the sake of fairness and acccuracy, I should offer the correction that this isn't really "abstraction". It's really just a feature of dealing with the natural boundary between what are really two distinct operating systems.* 

In trying to get any form of "seamless" copy/paste behavior to happen between the two (or perhaps even three, if we're talking about ssh'ing to a remote host...) OS's, you're essentially going to have to build a "bridge" between the clipboard on one OS to the other(s), and translate the corresponding registers between these distinct buffers. Obviously, on a Mac you're only really dealing with a single OS/clipboard buffer - so this is a much more straightforward/transparent operation (and easily taken for granted). 

Soooo the short answer is: *"Yes (at a minimum), you'll need to install an X-server of some sort (xming/VcXsrv/MobaXterm) if you want to share a clipboard b/w Linux and Windows - even when one (WSL) would appear to reside on the same host OS."*. 


**Update:** If you may still need/prefer to use ConEmu, I was able to (mostly) work around the trailing/leading whitespace issue as well as identify/reduce spaces before a tab by adding a few entries to my .vimrc.settings file:
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

This method arguably offers the least complicated remedy for cleaning up problematic whitespace.

Another annoyance I was committed to at least minimizing right away was the routine observation of my pasted text "cascading" in a sideways ripple, then becoming a series of steady waves before crashing against the margin of my text editor every time (which is all the time) I forget to type `:set paste`. While it hasn't improved my memory any, and the "tide" seems to come in only slightly less frequently, I've at least configured `F2` to toggle `:set paste` - so now I only have to type `u + F2` :)
```
" Press F2 to toggle set paste:
set pastetoggle=<F2>
```

#### SSH on WSL
I've found that using SSH in the familiar Mac/CentOS way can be a bit problematic to duplicate on WSL. I've had issues where I'd gotten what I thought was a reasonable handle on things, to suddenly be confronted with a "host key verification failed" message, when certainly nothing obvious had changed on any relevant host keys, permissions on any presumably relevant files, hostnames or ip addresses. Even removing individual entries from the `known_hosts` file, followed later by removing *everything* within this file, then finally deleting the file entirely and rebooting never once resulted in the usual/expected prompting to re-add the host key. I finally had to do the following to force host-key prompting, and re-establish ssh connectivy to my remote host:
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
Even after *painstakingly* examining the output of `ssh user@host -vvvvvvvvvvvvvvvvv` for clues, I was unable to figure out where Outlook had seemingly done it's "smart" formatting on an ssh public key that an end-user had copy/pasted into an email. Unless you want to go through the unnecessary motions of checking every link in this particularly heavy chain, I'd recommend you *insist* (gently, of course) that any public keys you intend on placing on a host arrive in a "tamper-resistant" `.pub` file ;)
##### **Oh, also, as of OpenSSH 7.0 ssh-dss keys don't work anymore. 
This has apparently been the case for at least a couple years now. Oddly, I have only really found this slender article discussing the issue here: https://meyering.net/nuke-your-DSA-keys/ - which was apparently written 7 years ago in 2010 - indicating the presence of an underlying vulnerability, and a full five years before the release of OpenSSH 7.0 (released August, 2015) where DSA support was finally dropped entirely.

SSH port forwarding/tunneling also seems pretty broken on WSL (at the very least it doesn't seem able to integrate with any real mechanism for name to number resolution, i.e. the `/etc/hosts` file appears at times as though it just gets ignored completely - or is perhaps less "authoritative" than the Windows-native "hosts" file. What this means is that you will typically need to use an ip address rather than the fqdn/hostname (including `127.0.0.1` instead of `localhost`) - unless the address would appear resolvable by a local/internal DNS server. You will also likely need sudo privileges in order to execute aliases/functions which may be configured to use "privileged ports" (which are really most network aliases/functions). 

In fact, I was never truly able to get ssh port-forwarding to work reliably in WSL - and perhaps collaterly why I started seeing the host key verification failures mentioned above - so you might be better served by using a native Windows app like PuTTY to accomplish this (I can report that this works quite well, if a little less intuitively in terms of initial setup than I had expected...).

**Update:** I was *finally* able to get **ssh multiplexing** to work, which has *all but completely eliminated a massive number of obstacles for me*... I'd describe this particular discovery as really the Sysadmin equivalent of feeling an immediate surge of supernatural power after being bitten by some weird glowing orange spider, or a sudden shirt-shredding green pectoral enormity after absorbing the entire radioactive, yet particularly nutrient-dense payload from an oddly unscrupulous, negligently-controlled yet curiously well-funded experiment featuring a highly-concentrated mix of weapons-grade plutonium, Human Growth Hormone, high-enzyme wheatgrass, and particularly viscous fish oil supplements :)

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

### Boxstarter

Definitely check out Boxstarter [here](http://boxstarter.org/InstallBoxstarter). Install it with [chocalatey](https://chocolatey.org/), the awesome package manager for Windows!  Here are some links to a few gists for use with Boxstarter:
* <https://gist.github.com/jessfraz/7c319b046daa101a4aaef937a20ff41f>
* <https://gist.github.com/NickCraver/7ebf9efbfd0c3eab72e9>
* <https://gist.github.com/rodtreweek/c07a1c5624728f610c56ff84c3172f8f>

### Docker for Windows

1. In addition to installing [Docker for Windows](https://www.docker.com/docker-windows) I also had to open up Powershell and run this:
```
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All
```
- which was necessary to get Hyper-V fully installed.

### Install GVM (Go Version Manager)
1. Although I ultimately didn't get very far with golang on my initial build, I have had success with it on a more recent Windows 10 build, so ymmv.
The Github repo and basic instructions are available [here](https://github.com/moovweb/gvm). 
First, install the following dependencies:
```
sudo apt-get install binutils bison gcc make
```
Then run the installer with:
- `zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)` - or if you're using bash as your shell, substitute `bash` for `zsh`.
2. Before you'll be able to install and use more recent golang versions, you'll first need to "bootstrap" gvm by installing, then using go1.4:
- `gvm install go1.4 -B`
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

**Note:** On earlier Windows 10 builds, I've had to turn off pyenv as it totally cripples WSL for me. Fortunately this issue appears to be resolved in later builds.

1. First, you'll probably need to install this stuff (so that things like bzip2 and sqlite work correctly):
```
sudo apt-get install -y python python-dev make build-essential libssl-dev zlib1g-dev libbz2-dev \
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
pyenv install jython-2.7.1
```
6. Once you have installed the versions of python you want, have a look at the docs here: https://github.com/pyenv/pyenv#choosing-the-python-version . In a nutshell, you'll need to use the `pyenv local` and `pyenv global` commands to set which versions of python you will want available to different projects.

## Final thoughts....

Other than this: https://www.reddit.com/r/tmux/comments/2xgrf8/garbage_characters_printed_to_screen_after_a/ - which I'm now appreciating more as a useful safeguard than an intrusive obstruction, and the possible exception of the problems I've had with Vagrant/Docker, this is still **much, much** more tolerable than anything else I have tried to date. Microsoft (or frankly any other enterprising/ambitious group of presumably C-coders) would seem to have a pretty significant opportunity here to introduce a *real terminal application that could absolutely blow away anything currently available*, and really be a suitable compliment to something like VScode - which would certainly go a long way to solidly supporting any claimed committment to developer advocacy :) I'd certainly be interested in hearing from anyone else who may have some thoughts on this (one way or the other).


### Blogs

Here are a few other blog posts I've also found helpful:

* Guide to using Tmux (take a look at the part related to installing xclip if you're having trouble copy/pasting from a remote system...ymmv): http://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/
* Here's the official xfce4-terminal docs page: http://docs.xfce.org/apps/terminal/start. I hope to offer more insights as I experiment with this.
* [Dariusz Parys's dev setup](https://medium.com/@dariuszparys/my-windows-10-dev-setup-67d7aecb63a6)
* [David Tran's setup guide](https://davidtranscend.com/blog/windows-terminal-workflow-guide)
* [Andreas Johansson's terminal setup guide](https://medium.com/@Andreas_cmj/how-to-setup-a-nice-looking-terminal-with-wsl-in-windows-10-creators-update-2b468ed7c326)
* [(Microsoft's) Brian Ketelsen offers a look at his dev setup here](https://brianketelsen.com/my-cross-platform-dev-setup-on-surface-laptop/) and also [here](https://brianketelsen.com/i3-windows/)
* [Mike Lindegarde's powerlevel9k theme setup on Windows 10 using (Cygwin-variant) Babun](http://mikelindegarde.com/post/2016/03/10/feeling-like-a-real-developer) (Also contains some good info on oh-my-zsh plugin configuration).
* [Rushi Agrawal's guide to Tmux copy/pasting](http://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/)
* [Scott Hanselman's setup](https://www.hanselman.com/blog/SettingUpAShinyDevelopmentEnvironmentWithinLinuxOnWindows10.aspx)
* [Jeff Geerling's guide to using Ansible on WSL](https://www.jeffgeerling.com/blog/2017/using-ansible-through-windows-10s-subsystem-linux)
* [More fonts...](http://input.fontbureau.com/)
* Although unfortunately this hasn't worked for me yet, (see 'build version' discussion above...) I'm quite happy to endorse the approach offered by "ropnop" here: https://blog.ropnop.com/configuring-a-pretty-and-usable-terminal-emulator-for-wsl/. This approach features the installation of VcXsrv to facilitate the use of the Linux Terminator terminal app.
* Fixing zsh-autocomplete auto-accept: https://jee-appy.blogspot.com/2017/06/tab-completion-is-not-working-oh-my-zsh.html
* This is great: https://nickjanetakis.com/blog/using-wsl-and-mobaxterm-to-create-a-linux-dev-environment-on-windows - Wish I would have found this much earlier than I did particularly the portion "WSL, ConEmu and MobaXterm to the Rescue".

I'll be continuing to frequently add/remove/edit items contained within this project (perhaps until I author a proper blog post elsewhere, and make what's here a bit more conventional, i.e. much lighter on editorial, heavier emphasis on clear/concise list of installation/configuration steps ;)
