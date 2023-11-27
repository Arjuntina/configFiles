#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Customizes the look of the prompt
PS1='\W >> '

# Make some commands look better :)
alias ls='ls --color=auto'
alias grep='grep --color=auto'
. "$HOME/.cargo/env"
