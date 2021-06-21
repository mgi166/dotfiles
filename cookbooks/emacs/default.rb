files_path = "cookbooks/emacs/files"

package "emacs" do
  options "--with-cocoa"
end

# NOTE: Deprecate `linkapps` command
execute "brew linkapps emacs" do
  not_if "[[ -e /Applications/Emacs.app ]]"
end

package "cask"

execute "cd #{files_path}/.emacs.d; cask install" do
  not_if "[[ -e #{files_path}/.emacs.d/.cask ]]"
end

link File.expand_path("~/.emacs.d") do
  to File.expand_path("cookbooks/emacs/files/.emacs.d")
  force true
end
