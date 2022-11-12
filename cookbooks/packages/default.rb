(node[:packages][:cask] + node[:packages][:develop] + node[:packages][:essential]).each do |package_name|
  package package_name
end
