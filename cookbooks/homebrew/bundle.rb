link File.expand_path("~/.Brewfile") do
  to File.expand_path("cookbooks/homebrew/files/.Brewfile")
  force true
end

execute "brew bundle --global" do
  not_if "brew bundle check --global"
end
