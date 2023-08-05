# copied from bash shell
# hard linked to ~/.zprofile with command "ln ~/.config/zsh/.zprofile ~/.zprofile"
# better than soft link? i think so


[[ -f ~/.zshrc ]] && . ~/.zshrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

