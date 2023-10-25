# hard linked to home directory with prompt "ln -s ~/.config/zsh/.zshrc ~/.zshrc"
# customize the look of the prompt
PS1='%~ > '

# Make some commands look better :)
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Make the path include emacs directory so doom emacs commands can be used
# Done here and not in .xinitrc so that emacs can run on the command line
export PATH=~/.config/emacs/bin:$PATH
