files_path = "cookbooks/emacs/files"

execute "git submodule update --init" do
  not_if "[[ -e #{files_path}/.emacs.d/elisp/replace-colorthemes ]] && [[ -e #{cookbooks_path}/.emacs.d/site-lisp/jumar ]] && [[ -e #{files_path}/.emacs.d/site-lisp/erfi ]]"
end

execute "cask install" do
  cwd ".emacs.d"
  not_if "[[ -e .emacs.d/.cask ]]"
end

link File.expand_path("~/.emacs.d") do
  to File.expand_path("cookbooks/emacs/files/.emacs.d")
  force true
end
