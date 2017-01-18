link File.expand_path("~/.gemrc") do
  to File.expand_path("cookbooks/gemrc/files/.gemrc")
  force true
end
