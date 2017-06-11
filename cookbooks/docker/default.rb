# Require docker command
execute "curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion.d/_docker-compose" do
  not_if "[[ -e ~/.zsh/completion.d/_docker-compose ]]"
end
