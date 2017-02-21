files_path = "cookbooks/emacs/files"

execute "git submodule update --init" do
  not_if "[[ -e #{files_path}/.emacs.d/elisp/replace-colorthemes ]] && [[ -e #{files_path}/.emacs.d/site-lisp/jumar ]] && [[ -e #{files_path}/.emacs.d/site-lisp/erfi ]]"
end

package "cask"

execute "cd #{files_path}/.emacs.d; cask install" do
  not_if "[[ -e #{files_path}/.emacs.d/.cask ]]"
end

link File.expand_path("~/.emacs.d") do
  to File.expand_path("cookbooks/emacs/files/.emacs.d")
  force true
end
