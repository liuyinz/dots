# https://stackoverflow.com/a/60987764/13194984
# solve .zshenv $PATH order chaos , `set -x` to debug

[[ -f ~/.zshenv ]] && source ~/.zshenv

typeset -U PATH
# typeset -U PYTHONPATH
