# NOTE: Change screenshot settings. See http://ichitaso.com/mac/tips-for-os-x-screenshot/
#
execute "defaults write com.apple.screencapture location '~/Pictures/Screenshots'"
execute "defaults write com.apple.screencapture name 'screenshot'"
execute "killall SystemUIServer"
