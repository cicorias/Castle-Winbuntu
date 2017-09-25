# Path to your oh-my-zsh configuration
export ZSH=$HOME/.oh-my-zsh

# Let's try using 256 Colors.
export TERM="xterm-256color"

# Set name of the theme to load.
#ZSH_THEME='powerlevel9k' # I've had to turn this off for now. Too slow :(
ZSH_THEME="robbyrussell"
DEFAULT_USER=$USER

# PowerLevel9K options. # These will remain off for now, since this is pretty busted on early WSL builds :(
#POWERLEVEL9K_MODE='awesome-patched'
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv background_jobs)
#POWERLEVEL9K_STATUS_VERBOSE=false
#POWERLEVEL9K_HOME_ICON=''
#POWERLEVEL9K_HOME_SUB_ICON=''
#POWERLEVEL9K_FOLDER_ICON=''
#POWERLEVEL9K_VCS_GIT_ICON=''
#POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
#POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
#POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
#POWERLEVEL9K_HIDE_BRANCH_ICON=true

# # Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Hurray for ssh-agent plugin!!
plugins=(git osx ruby rbenv gem vagrant ssh-agent tmux zsh-syntax-highlighting docker docker-compose)

# Color correct paths rather than underlining them.
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

# Load SSH identities
zstyle :omz:plugins:ssh-agent identities id_rsa

# Start oh-my-zsh
source $ZSH/oh-my-zsh.sh

# PATH modifications. Don't modify if we're in TMUX because path_helper does it for us.
# I also modifed /etc/zprofile as shown here https://pgib.me/blog/2013/10/11/macosx-tmux-zsh-rbenv/
if [[ -z $TMUX ]]; then

# Add ~/.bin to PATH
export PATH="$PATH:$HOME/.bin"
# Add homebrew's sbin dir to PATH
# export PATH="/usr/local/sbin:$PATH"

# Initialize rbenv
if which rbenv >/dev/null ; then
[[ $PATH =~ 'rbenv/shims' ]] || eval "$(rbenv init -)"
fi
fi

# Source my external alias config
# NOTE about 'ls': If coreutils is installed, oh-my-zsh will alias ls to gls, but
# something about it is broken which breaks ls. not sure...
source $HOME/.aliases
