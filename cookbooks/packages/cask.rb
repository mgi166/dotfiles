node[:packages][:cask].each do |package_name|
  package package_name do
    options "--cask"
  end
end
