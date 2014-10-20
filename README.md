dotfiles
========

# Install
You execute the installation, create symbolic link files to your home directory.  
If file name you want to install is already exist, ask you if you want to install and back up it.  

### All dotfiles install
```zsh
git clone https://github.com/mgi166/dotfiles.git
rake install
```

### Custom install
You want to install only the file that you specify, give file name with argument.  

```zsh
rake install .tmux.conf
```

# Uninstall
Remove all symbolic link you installed.  

```zsh
rake uninstall
```

### Custom uninstall
You want to uninstall only the file that you specify, give file name with an argument.  

```zsh
rake uninstall .tmux.conf
```
