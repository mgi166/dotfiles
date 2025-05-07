# NOTE: Change screenshot settings. See http://ichitaso.com/mac/tips-for-os-x-screenshot/
#

location = "~/Pictures/Screenshots"

directory File.expand_path("~/Pictures/Screenshots")

# Screencapture path
execute "defaults write com.apple.screencapture location -string '#{location}'" do
  not_if "defaults read com.apple.screencapture location | grep '^#{location}$'"
  notifies :run, 'execute[killall SystemUIServer]'
end

screenshot_name = "screenshot"

# screencapture name format
execute "defaults write com.apple.screencapture name -string '#{screenshot_name}'" do
  not_if "defaults read com.apple.screencapture name | grep '^#{screenshot_name}$'"
  notifies :run, 'execute[killall SystemUIServer]'
end

execute "killall SystemUIServer" do
  action :nothing
end

# Install rosetta
execute "sudo softwareupdate --install-rosetta" do
  not_if "(uname -m | grep arm64) && (pkgutil --files com.apple.pkg.RosettaUpdateAuto | grep rosetta)"
end

# Finder
execute "defaults write NSGlobalDomain AppleShowAllExtensions -bool true" do
  not_if "defaults read NSGlobalDomain AppleShowAllExtensions | grep 1"
  notifies :run, 'execute[killall Finder]'
end

execute "defaults write com.apple.finder ShowSidebar -bool true" do
  not_if "defaults read com.apple.finder ShowSidebar | grep 1"
  notifies :run, 'execute[killall Finder]'
end

execute "killall Finder" do
  action :nothing
end

# Dock
execute "killall Dock" do
  action :nothing
end

execute "defaults write com.apple.dock autohide -bool true" do
  not_if "defaults read com.apple.dock autohide | grep 1"
  notifies :run, 'execute[killall Dock]'
end

execute "defaults write com.apple.dock magnification -bool true" do
  not_if "defaults read com.apple.dock magnification | grep 1"
  notifies :run, 'execute[killall Dock]'
end

execute "defaults write com.apple.dock largesize -int 128" do
  not_if "defaults read com.apple.dock largesize | grep 128"
  notifies :run, 'execute[killall Dock]'
end

execute "defaults write com.apple.dock tilesize -int 16" do
  not_if "defaults read com.apple.dock tilesize | grep 16"
  notifies :run, 'execute[killall Dock]'
end

## General
# smart dash disable
execute "defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false" do
  not_if "defaults read NSGlobalDomain NSAutomaticDashSubstitutionEnabled | grep 0"
  notifies :run, 'execute[killall SystemUIServer]'
end

# smart quote disable
execute "defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false" do
  not_if "defaults read NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled | grep 0"
  notifies :run, 'execute[killall SystemUIServer]'
end

## trackpad
execute "defaults write NSGlobalDomain com.apple.trackpad.forceClick -int 1" do
  not_if "defaults read NSGlobalDomain com.apple.trackpad.forceClick | grep 1"
end

# Change trackpad scrolling speed
# 0: Slow
# 3: Fast
execute "defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5" do
  not_if "defaults read NSGlobalDomain com.apple.trackpad.scaling | grep 2.5"
end

# Change trackpad scroll direction
# true: Natural
# false: Not natural
execute "defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false" do
  not_if "defaults read NSGlobalDomain com.apple.swipescrolldirection | grep 0"
end

# Change `In windows and dialogs, press Tab to move keyboard focus between All controls`
# 2: `tab` key forcus to next control, `shift + tab` key forcus to previous it
# 0: Any key has no shortcut
execute "defaults write NSGlobalDomain AppleKeyboardUIMode -int 2" do
  not_if "defaults read NSGlobalDomain AppleKeyboardUIMode | grep 2"
end

# Show battery percent
execute 'defaults write com.apple.menuextra.battery ShowPercent -string "YES"' do
  not_if "defaults read com.apple.menuextra.battery ShowPercent | grep YES"
end

# shortcut key
disable_launch_spotlight_source_map = <<~EOS.gsub(/\s+/, "")
<dict>
  <key>enabled</key><false/>
  <key>value</key><dict>
    <key>type</key><string>standard</string>
    <key>parameters</key>
      <array>
        <integer>65535</integer>
        <integer>49</integer>
        <integer>1048576</integer>
      </array>
  </dict>
</dict>
EOS

# NOTE: Default command + space shortcut is disable
execute "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '#{disable_launch_spotlight_source_map}'" do
  not_if "defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys | egrep '\s+64 =' -A 1 | grep 'enabled = 0'"
  notifies :run, 'execute[/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u]'
end

select_next_input_source_map = <<~EOS.gsub(/\s+/, "")
<dict>
  <key>enabled</key><true/>
  <key>value</key><dict>
    <key>type</key><string>standard</string>
    <key>parameters</key>
      <array>
        <integer>32</integer>
        <integer>49</integer>
        <integer>1048576</integer>
      </array>
  </dict>
</dict>
EOS

# NOTE: command + space shortcut execute `select next input source`
execute "defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 '#{select_next_input_source_map}'" do
  not_if "defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys | egrep '\s+61 =' -A 1 | grep 'enabled = 1'"
  notifies :run, 'execute[/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u]'
end

execute "/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u" do
  action :nothing
end
