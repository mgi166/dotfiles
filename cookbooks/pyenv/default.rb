git File.expand_path("~/.pyenv") do
  repository "https://github.com/yyuu/pyenv.git"
end

python_version = "2.7.13"

execute "pyenv install #{python_version}" do
  not_if "pyenv versions | grep #{python_version}"
end

execute "pyenv global #{python_version}" do
  not_if "pyenv versions | grep '\*' | grep #{python_version}"
end
