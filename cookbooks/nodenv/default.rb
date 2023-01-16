git File.expand_path("~/.nodenv") do
  repository "https://github.com/nodenv/nodenv.git"
end

git File.expand_path("~/.nodenv/plugins/node-build") do
  repository "https://github.com/nodenv/node-build.git"
end
