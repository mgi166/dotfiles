execute "git submodule update --init" do
  not_if "[[ -e .emacs.d/elisp/replace-colorthemes ]] && [[ -e .emacs.d/site-lisp/jumar ]] && [[ -e .emacs.d/site-lisp/erfi ]]"
end

execute "cask install" do
  cwd ".emacs.d"
  not_if "[[ -e .emacs.d/.cask ]]"
end

link File.expand_path("~/.emacs.d") do
  to File.expand_path(".emacs.d")
  force true
end
