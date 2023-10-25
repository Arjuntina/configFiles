# copied from bash shell
# hard linked to ~/.zprofile with command "ln ~/.config/zsh/.zprofile ~/.zprofile"
# better than soft link? i think so

# If .zshrc found, then initialize somehow (i think)
[[ -f ~/.zshrc ]] && . ~/.zshrc


# If there is a display and the first virtual environment is used, then start x server i think
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

