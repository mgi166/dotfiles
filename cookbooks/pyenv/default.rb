git File.expand_path("~/.pyenv") do
  repository "https://github.com/yyuu/pyenv.git"
end

python_version = "3.6.0"

execute "pyenv install #{python_version}" do
  not_if "pyenv versions | grep #{python_version}"
end

execute "pyenv global #{python_version}" do
  not_if "pyenv versions | grep '\*' | grep #{python_version}"
end
