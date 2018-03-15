git File.expand_path("~/.goenv") do
  repository "https://github.com/syndbg/goenv.git"
end

go_version = "1.10.0"

execute "goenv install #{go_version}" do
  not_if "goenv versions | grep #{go_version}"
end

execute "goenv global #{go_version}" do
  not_if "goenv versions | grep '\*' | grep #{go_version}"
end
