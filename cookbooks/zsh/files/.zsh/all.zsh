[ -f $HOME/.zsh/env.zsh ]        && source $HOME/.zsh/env.zsh
[ -f $HOME/.zsh/alias.zsh ]      && source $HOME/.zsh/alias.zsh
[ -f $HOME/.zsh/color.zsh ]      && source $HOME/.zsh/color.zsh
[ -f $HOME/.zsh/completion.zsh ] && source $HOME/.zsh/completion.zsh
[ -f $HOME/.zsh/function.zsh ]   && source $HOME/.zsh/function.zsh
[ -f $HOME/.zsh/history.zsh ]    && source $HOME/.zsh/history.zsh
[ -f $HOME/.zsh/option.zsh ]     && source $HOME/.zsh/option.zsh
[ -f $HOME/.zsh/prompt.zsh ]     && source $HOME/.zsh/prompt.zsh

# environment dependence file
[ -f $HOME/.zsh/.zshrc_`uname` ] && . $HOME/.zsh/.zshrc_`uname`
[ -f $HOME/.zsh/.zshrc_local ]   && . $HOME/.zsh/.zshrc_local
