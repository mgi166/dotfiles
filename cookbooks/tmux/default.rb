package "tmux"

link File.expand_path("~/.tmux.conf") do
  to File.expand_path("cookbooks/tmux/files/.tmux.conf")
  force true
end
