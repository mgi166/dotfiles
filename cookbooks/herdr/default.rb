package "herdr"

directory File.expand_path("~/.config/herdr")

link File.expand_path("~/.config/herdr/config.toml") do
  to File.expand_path("cookbooks/herdr/files/.config/herdr/config.toml")
  force true
end

link File.expand_path("~/.config/herdr/focus-pane-cyclic.sh") do
  to File.expand_path("cookbooks/herdr/files/.config/herdr/focus-pane-cyclic.sh")
  force true
end
