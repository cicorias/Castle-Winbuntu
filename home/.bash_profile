#!/bin/bash
#SSH-agent config (I'm currently using an oh-my-zsh plugin for this, hence the comments...)
#stty_orig=`stty -g`
#stty -echo
#if [ -z "$SSH_AUTH_SOCK"  ] ; then
#          eval `ssh-agent -s`
#   ssh-add
#fi
#stty $stty_orig

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,aliases,functions,path,dockerfunc,extra,exports}; do
        if [[ -r "$file" ]] && [[ -f "$file" ]]; then
                # shellcheck source=/dev/null
                source "$file"
        fi
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
        shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
        -o "nospace" \
        -W "$(grep "^Host" ~/.ssh/config | \
        grep -v "[?*]" | cut -d " " -f2 | \
        tr ' ' '\n')" scp sftp ssh

# print a fortune when the terminal opens
#fortune -a -s | lolcat

# Path to the bash it configuration
export BASH_IT="$HOME/bash-it"

# Lock and Load a custom theme file (this is currently tooo slow on WSL...)
# location /.bash_it/themes/
#export BASH_IT_THEME='minimal'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Don't check mail when opening terminal.
#unset MAILCHECK

# Change this to your console based IRC client of choice.
#export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
#export TODO="t"

# Load Bash It (currently disabled as I try out oh-my-zsh)
# source "$BASH_IT"/bash_it.sh

# Virtualenv
#WORKON_HOME=~/Envs
#source /usr/local/bin/virtualenvwrapper.sh

# GVM
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
