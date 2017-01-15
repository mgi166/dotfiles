git File.expand_path("~/.rbenv") do
  repository "https://github.com/rbenv/rbenv.git"
end

link File.expand_path("~/.rbenv/default-gems") do
  to File.expand_path("./default-gems")
  force true
end

git File.expand_path("~/.rbenv/plugins/ruby-build") do
  repository "https://github.com/sstephenson/ruby-build.git"
end

git File.expand_path("~/.rbenv/plugins/rbenv-default-gems") do
  repository "https://github.com/sstephenson/rbenv-default-gems.git"
end

git File.expand_path("~/.rbenv/plugins/rbenv-update") do
  repository "https://github.com/rkh/rbenv-update.git"
end

ruby_version = "2.3.3"

execute "rbenv install #{ruby_version}" do
  not_if "rbenv versions | grep #{ruby_version}"
end

execute "rbenv global #{ruby_version}" do
  not_if "rbenv versions | grep '\*' | grep #{ruby_version}"
end
