git File.expand_path("~/.homebrew") do
  repository "https://github.com/Homebrew/brew.git"
  not_if "[[ -e ~/.homebrew ]]"
end
