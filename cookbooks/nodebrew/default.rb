execute "curl -L git.io/nodebrew | perl - setup" do
  not_if "[[ -e ~/.nodebrew ]]"
end

node_version = "6.9.4"

execute "PATH=$HOME/.nodebrew/current/bin:$PATH nodebrew install-binary v#{node_version}" do
  not_if "nodebrew ls | grep '^v#{node_version}$'"
end

execute "PATH=$HOME/.nodebrew/current/bin:$PATH nodebrew use v#{node_version}" do
  not_if "nodebrew ls | grep current | grep #{node_version}"
end
