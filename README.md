dotfiles
========

# Install
You execute the installation, create symbolic link files to your home directory. If file name you want to install is already exist, ask you if you want to install and back up it.  

### All dotfiles install
```zsh
git clone https://github.com/mgi166/dotfiles.git
rake dotfiles:install
```

### Custom install
You want to install only the file that you specify, give file name with argument.  

```zsh
rake dotfiles:install .tmux.conf
```

If set environments "f", The same like this  

```zsh
rake dotfiles:install f=.tmux.conf
```

# Uninstall
Remove all symbolic link you installed.  
```zsh
rake dotfiles:uninstall
```

### Custom uninstall
You want to uninstall only the file that you specify, give file name with an argument.  

```zsh
rake dotfiles:uninstall .tmux.conf
```
