link File.expand_path("~/.gitconfig") do
  to File.expand_path("cookbooks/gitconfig/files/.gitconfig")
  force true
end
