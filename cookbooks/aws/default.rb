directory File.expand_path("~/.aws") do
  action :create
end

link File.expand_path("~/.aws/config") do
  to File.expand_path("cookbooks/aws/files/.aws/config")
  force true
end

# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-mac.html
execute "install awscli@v2" do
  command <<~EOF
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
  EOF
  if_not "which aws"
end
