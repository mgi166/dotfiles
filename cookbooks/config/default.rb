# TODO: create ~/.config dir only
link File.expand_path("~/.config") do
  to File.expand_path("cookbooks/config/files/.config")
  force true
end
