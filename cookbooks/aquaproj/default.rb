directory File.expand_path("~/.aqua/global")

link File.expand_path("~/.aqua/global/aqua.yaml") do
  to File.expand_path("cookbooks/aquaproj/files/aqua.yaml")
  force true
end
