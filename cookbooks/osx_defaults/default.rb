# NOTE: Change screenshot settings. See http://ichitaso.com/mac/tips-for-os-x-screenshot/
#

location = "~/Pictures/Screenshots"

directory File.expand_path("~/Pictures/Screenshots")

execute "defaults write com.apple.screencapture location '#{location}'" do
  not_if "defaults read com.apple.screencapture location | grep '^#{location}$'"
  notifies :run, 'execute[killall SystemUIServer]'
end

screenshot_name = "screenshot"

execute "defaults write com.apple.screencapture name '#{screenshot_name}'" do
  not_if "defaults read com.apple.screencapture name | grep '^#{screenshot_name}$'"
  notifies :run, 'execute[killall SystemUIServer]'
end

execute "killall SystemUIServer" do
  action :nothing
end
