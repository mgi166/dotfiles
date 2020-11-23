directory File.expand_path("~/.aws") do
  action :create
end

link File.expand_path("~/.aws/config") do
  to File.expand_path("cookbooks/aws/files/.aws/config")
  force true
end
