directory File.expand_path("~/.ssh") do
  action :create
end

template File.expand_path("~/.ssh/config") do
  action :create
  source "templates/config"
end
