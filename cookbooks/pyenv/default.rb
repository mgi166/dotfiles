git File.expand_path("~/.pyenv") do
  repository "https://github.com/pyenv/pyenv.git"
end

git File.expand_path("~/.pyenv/plugins/pyenv-update") do
  repository "https://github.com/pyenv/pyenv-update.git"
end
