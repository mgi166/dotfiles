execute "install whalebrew" do
  command 'curl -L "https://github.com/bfirsh/whalebrew/releases/download/0.1.0/whalebrew-$(uname -s)-$(uname -m)" -o /usr/local/bin/whalebrew; chmod +x /usr/local/bin/whalebrew'
  not_if "which whalebrew"
end
