files_path = "cookbooks/emacs/files"

package "emacs" do
  options "--cask"
end

package "cask"

link File.expand_path("~/.emacs.d") do
  to File.expand_path("cookbooks/emacs/files/.emacs.d")
  force true
end

execute "cd #{files_path}/.emacs.d; cask install" do
  not_if "[[ -e #{files_path}/.emacs.d/.cask ]]"
end
