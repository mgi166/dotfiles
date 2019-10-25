link File.expand_path("~/.gitconfig") do
  to File.expand_path("cookbooks/gitconfig/files/.gitconfig")
  force true
end

link File.expand_path("~/.gitmessage.txt") do
  to File.expand_path("cookbooks/gitconfig/files/.gitmessage.txt")
  force true
end
