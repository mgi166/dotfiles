link File.expand_path("~/.tmux.conf") do
  to File.expand_path("cookbooks/tmux/files/.tmux.conf")
  force true
end

execute "pip install powerline-status" do
  not_if "which pyenv > /dev/null && (pip list | grep powerline-status)"
end

execute "pip install --user git+git://github.com/powerline/powerline" do
  not_if "which pyenv > /dev/null && which powerline > /dev/null"
end
