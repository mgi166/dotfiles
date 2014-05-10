# default
[ -f $ZDOTDIR/alias.zsh ]      && source $ZDOTDIR/alias.zsh
[ -f $ZDOTDIR/color.zsh ]      && source $ZDOTDIR/color.zsh
[ -f $ZDOTDIR/env.zsh ]        && source $ZDOTDIR/env.zsh
[ -f $ZDOTDIR/completion.zsh ] && source $ZDOTDIR/completion.zsh
[ -f $ZDOTDIR/function.zsh ]   && source $ZDOTDIR/function.zsh
[ -f $ZDOTDIR/history.zsh ]    && source $ZDOTDIR/history.zsh
[ -f $ZDOTDIR/option.zsh ]     && source $ZDOTDIR/option.zsh
[ -f $ZDOTDIR/prompt.zsh ]     && source $ZDOTDIR/prompt.zsh

# environment dependence file
[ -f $ZDOTDIR/.zshrc_`uname` ] && . $ZDOTDIR/.zshrc_`uname`
[ -f $ZDOTDIR/.zshrc_local ]   && . $ZDOTDIR/.zshrc_local
