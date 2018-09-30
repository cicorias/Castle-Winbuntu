# Path to your oh-my-zsh configuration
export DISPLAY="localhost:0"
export ZSH=$HOME/.oh-my-zsh

# Colorz cuz WSL is ugly.
if [ -f ~/.dir_colors ]; then
  eval `dircolors ~/.dir_colors`
fi

# Install zplug
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/b4b4r07/zplug ~/.zplug
fi
export ZPLUG_HOME=$HOME/.zplug

# 256 Colors.
export TERM="xterm-256color"

# Set name of the theme to load.
ZSH_THEME="robbyrussell" # Use this if you want faster...
# ZSH_THEME='powerlevel9k' # Too slow in early WSL builds, somewhat better in 17xxx builds
DEFAULT_USER=$USER

# PowerLevel9K options. # Note: this is pretty busted on early WSL builds :(
# POWERLEVEL9K_MODE='awesome-patched'

# Disable dir/git icons
# POWERLEVEL9K_HOME_ICON=''
# POWERLEVEL9K_HOME_SUB_ICON=''
# POWERLEVEL9K_FOLDER_ICON=''
# POWERLEVEL9K_VCS_GIT_ICON=''
# POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
# POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
# POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context dir dir_writable)
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status os_icon context dir dir_writable vcs)
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status ssh root_indicator dir dir_writable vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs virtualenv rbenv time)
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
# POWERLEVEL9K_TIME_FORMAT="%D{%H:%M | %m-%d-%y}"
# POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
# POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
# POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
# POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
# POWERLEVEL9K_VCS_COMMIT_ICON='\uf417'
# POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
# POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
# POWERLEVEL9K_HIDE_BRANCH_ICON=true
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%F{white}"
# POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{white} "
HIST_STAMPS="mm/dd/yyyy"
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context os_icon ssh root_indicator dir dir_writable vcs)
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status time)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)

# # Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Hurray for ssh-agent plugin!!
plugins=(colored-man-pages git ssh-agent extract)
autoload -U compinit && compinit

# Color correct paths rather than underlining them.
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

# Load SSH identities
zstyle :omz:plugins:ssh-agent identities id_rsa

# Start oh-my-zsh and zplug
source $ZSH/oh-my-zsh.sh
source $ZPLUG_HOME/init.zsh

# PATH modifications. Don't modify if we're in TMUX because path_helper does it for us.
# I also modifed /etc/zprofile as shown here https://pgib.me/blog/2013/10/11/macosx-tmux-zsh-rbenv/
if [[ -z $TMUX ]]; then
  # Add ~/.bin to PATH
  export PATH="$PATH:$HOME/.bin"
  export PATH="/usr/local/sbin:$PATH"
  export PATH="$HOME/.zplug/bin:$PATH"
fi

# Add homebrew's sbin dir to PATH
# export PATH="/usr/local/sbin:$PATH"

# Load plugin files
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# zplug "tj/git-extras", use:"etc/git-extras-completion.zsh", defer:3, if:"[[ $(command -v git) ]]"
zplug "tmuxinator/tmuxinator", use:".bin/tmuxinator.zsh", defer:3, if:"[[ $(command -v tmuxinator) ]]"

zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "supercrabtree/k"

# bindkey for zsh-autosuggestions
bindkey '**' autosuggest-accept

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load

# Initialize rbenv
if which rbenv >/dev/null ; then
[[ $PATH =~ 'rbenv/shims' ]] || eval "$(rbenv init -)"
fi

#Initialize pyenv
export PATH="${HOME}/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

#Initialize GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
	gpg-connect-agent /bye >/dev/null 2>&1
fi
gpg-connect-agent updatestartuptty /bye >/dev/null
# use a tty for gpg
# solves error: "gpg: signing failed: Inappropriate ioctl for device"
GPG_TTY=$(tty)
export GPG_TTY
# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	if [[ -z "$SSH_AUTH_SOCK" ]] || [[ "$SSH_AUTH_SOCK" == *"apple.launchd"* ]]; then
		SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
		export SSH_AUTH_SOCK
	fi
fi
# add alias for ssh to update the tty
alias ssh="gpg-connect-agent updatestartuptty /bye >/dev/null; ssh"

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,functions,path,extra,exports}; do
  if [[ -r "$file" ]] && [[ -f "$file" ]]; then
  source "$file"
  fi
done
unset file

# Start Tmuxinator daily sesh...
source "$HOME/.bin/tmuxinator.zsh"
# tmuxinator start daily
export DOCKER_HOST=tcp://0.0.0.0:2375
