link File.expand_path("~/.bundle") do
  to File.expand_path("cookbooks/bundle/files/.bundle")
  force true
end

# NOTE: Require libxml2
execute 'Set nokogiri build configuration' do
  command "bundle config build.nokogiri --use-system-libraries --with-xml2-include=$(brew --prefix libxml2)/include/libxml2"
  not_if "bundle config build.nokogiri | grep use-system-libraries"
end
