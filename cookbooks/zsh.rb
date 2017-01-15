package "zsh"

zsh_path = "#{ENV["HOME"]}/.homebrew/bin/zsh"

execute "echo \"#{zsh_path}\" >> /etc/shells" do
  user "root"
  not_if "grep '^#{zsh_path}$' /etc/shells"
end

execute "chsh -s #{zsh_path}" do
  not_if "echo $SHELL | grep '^#{zsh_path}$'"
end

link File.expand_path("~/.zshrc") do
  to File.expand_path(".zshrc")
  force true
end

link File.expand_path("~/.zsh") do
  to File.expand_path(".zsh")
  force true
end
