# hard linked to home directory with prompt "ln -s ~/.config/zsh/.zshrc ~/.zshrc"
# customize the look of the prompt
PS1='%~ > '

# Make some commands look better :)
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# alternate (cooler) neofetch with random config :)
if [ -f "/home/arjuntina/Software/Boogaloo/neofetchRandom.sh" ] && [ -d "/home/arjuntina/.config/neofetch/allConfigs" ] ; then
    alias neofetch='/home/arjuntina/Software/Boogaloo/neofetchRandom.sh'
fi

