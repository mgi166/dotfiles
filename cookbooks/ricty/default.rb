execute "brew tap sanemat/font" do
  not_if "brew tap --full | grep sanemat/font"
end

package "ricty" do
  options "--with-powerline"
end

execute "cp -f $HOMEBREW_PREFIX/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/ && fc-cache -vf" do
  not_if "ls ~/Library/Fonts/Ricty* | grep -i ricty"
end
