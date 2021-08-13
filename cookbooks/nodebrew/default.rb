execute "curl -L git.io/nodebrew | perl - setup" do
  not_if "[[ -e ~/.nodebrew ]]"
end
