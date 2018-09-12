# Path to your oh-my-zsh configuration
export DISPLAY="localhost:0"
export ZSH=$HOME/.oh-my-zsh

# Install zplug
# You can customize where you put it but it's generally recommended that you put in $HOME/.zplug
if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

export ZPLUG_HOME=$HOME/.zplug

# Let's try using 256 Colors.
export TERM="xterm-256color"

# Set name of the theme to load.
ZSH_THEME='powerlevel9k' # I've had to turn this off for now. Too slow :(
#ZSH_THEME="robbyrussell"
DEFAULT_USER=$USER

# PowerLevel9K options. # These will remain off for now, since this is pretty busted on early WSL builds :(
POWERLEVEL9K_MODE='awesome-patched'
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv background_jobs)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
POWERLEVEL9K_HIDE_BRANCH_ICON=true

# Disable dir/git icons
# POWERLEVEL9K_HOME_ICON=''
# POWERLEVEL9K_HOME_SUB_ICON=''
# POWERLEVEL9K_FOLDER_ICON=''

# DISABLE_AUTO_TITLE="true"
# POWERLEVEL9K_VCS_GIT_ICON=''
# POWERLEVEL9K_VCS_STAGED_ICON='\u00b1'
# POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
# POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
# POWERLEVEL9K_VCS_COMMIT_ICON="\uf417"
# POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
# POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status os_icon context dir dir_writable vcs)
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context dir dir_writable)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs virtualenv rbenv time)
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \uE868  %m.%d.%y}"
# POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%F{white}"
# POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{white} "
HIST_STAMPS="mm/dd/yyyy"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status ssh root_indicator dir dir_writable vcs)
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context os_icon ssh root_indicator dir dir_writable vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time  status  time)


# # Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Hurray for ssh-agent plugin!!
plugins=(colorize colored-man-pages git ruby rbenv gem vagrant ssh-agent tmux zsh-completions zsh-autosuggestions extract)
autoload -U compinit && compinit

# bindkey for zsh-autosuggestions
bindkey '**' autosuggest-accept

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
# Add homebrew's sbin dir to PATH
# export PATH="/usr/local/sbin:$PATH"
#
# Load plugin files
zplug 'supercrabtree/k'
zplug 'zdharma/fast-syntax-highlighting'
zplug 'felixr/docker-zsh-completion'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# Initialize rbenv
if which rbenv >/dev/null ; then
[[ $PATH =~ 'rbenv/shims' ]] || eval "$(rbenv init -)"
fi
fi

#Initialize GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{aliases,functions,path,dockerfunc,extra,exports}; do
        if [[ -r "$file" ]] && [[ -f "$file" ]]; then
                source "$file"
        fi
done
unset file
