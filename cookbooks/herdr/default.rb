package "herdr"

link File.expand_path("~/.config/herdr") do
  to File.expand_path("cookbooks/herdr/files/.config/herdr")
  force true
end
