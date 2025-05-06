BUNDLE_FILE_NAME = "ABC-without-greek-alphabet.bundle"
KEYBOARD_LAYOUT_BASE_PATH = File.expand_path("cookbooks/osx_defaults/files")
KEYBOARD_LAYOUT_ZIP_PATH = File.expand_path("#{KEYBOARD_LAYOUT_BASE_PATH}/#{BUNDLE_FILE_NAME}.zip")
KEYBOARD_LAYOUT_FILE_PATH = File.expand_path("#{KEYBOARD_LAYOUT_BASE_PATH}/#{BUNDLE_FILE_NAME}")

execute "unzip #{KEYBOARD_LAYOUT_ZIP_PATH} -d #{KEYBOARD_LAYOUT_BASE_PATH}" do
  not_if "[[ -e #{KEYBOARD_LAYOUT_FILE_PATH} ]]"
end

execute "mv #{KEYBOARD_LAYOUT_BASE_PATH}/#{BUNDLE_FILE_NAME} #{File.expand_path("~/Library/Keyboard\\ Layouts/")}" do
  not_if "[[ -e #{File.expand_path("~/Library/Keyboard\\ Layouts/")} ]]"
end
