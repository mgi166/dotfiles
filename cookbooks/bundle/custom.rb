# NOTE: Require libxml2
# NOTE: If bundle failed to install nokogiri, use this ricipe.
execute 'Set nokogiri build configuration' do
  command "bundle config build.nokogiri --use-system-libraries --with-xml2-include=$(brew --prefix libxml2)/include/libxml2"
  not_if "bundle config build.nokogiri | grep use-system-libraries"
end
