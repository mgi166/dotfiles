-- NOTE: For sample from  http://qiita.com/naoya@github/items/81027083aeb70b309c14
local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      if key then
         hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
         hs.timer.usleep(1000)
         hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
      else
         for idx, key in pairs(modifiers) do
            hs.eventtap.event.newKeyEvent(hs.keycodes.map[key], true):post()
         end
         hs.timer.usleep(1000)
         for idx, key in pairs(modifiers) do
            hs.eventtap.event.newKeyEvent(hs.keycodes.map[key], false):post()
         end
      end
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

-- local function disableAllHotkeys()
--    for k, v in pairs(hs.hotkey.getHotkeys()) do
--       v['_hk']:disable()
--    end
-- end

-- local function enableAllHotkeys()
--    for k, v in pairs(hs.hotkey.getHotkeys()) do
--       v['_hk']:enable()
--    end
-- end

-- local function handleGlobalAppEvent(name, event, app)
--    if event == hs.application.watcher.activated then
--       -- hs.alert.show(name)
--       if name ~= "iTerm2" then
--          disableAllHotkeys()
--       elseif name ~= "Emacs" then
--          disableAllHotkeys()
--       else
--          enableAllHotkeys()
--       end
--    end
-- end

-- appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
-- appsWatcher:start()

-- カーソル移動
-- remapKey({'ctrl'}, 'f', keyCode('right'))
-- remapKey({'ctrl'}, 'b', keyCode('left'))
-- remapKey({'ctrl'}, 'n', keyCode('down'))
-- remapKey({'ctrl'}, 'p', keyCode('up'))
-- remapKey({'alt'}, 'f', keyCode('right', {'alt'}))
-- remapKey({'alt'}, 'b', keyCode('left', {'alt'}))

-- テキスト編集
-- remapKey({'ctrl'}, 'w', keyCode('x', {'cmd'}))
-- remapKey({'ctrl'}, 'y', keyCode('v', {'cmd'}))

-- コマンド
-- remapKey({'ctrl'}, 'g', keyCode('escape'))

-- ページスクロール
-- remapKey({'ctrl'}, 'v', keyCode('pagedown'))
-- remapKey({'alt'}, 'v', keyCode('pageup'))
remapKey({'alt', 'shift'}, ',', keyCode('home'))
remapKey({'alt', 'shift'}, '.', keyCode('end'))

-- NOTE: For debug
-- http://kitak.hatenablog.jp/entry/2016/11/28/104038
local function showKeyPress(tapEvent)
    local charactor = hs.keycodes.map[tapEvent:getKeyCode()]
    hs.alert.show(charactor, 1.5)
end

local keyTap = hs.eventtap.new(
  {hs.eventtap.event.types.keyDown},
  showKeyPress
)

k = hs.hotkey.modal.new({"cmd", "shift", "ctrl"}, 'P')

function k:entered()
  hs.alert.show("Enabling Keypress Show Mode", 1.5)
  keyTap:start()
end

function k:exited()
  hs.alert.show("Disabling Keypress Show Mode", 1.5)
end

k:bind({"cmd", "shift", "ctrl"}, 'P', function()
    keyTap:stop()
    k:exit()
end)


-- Google Chrome keybinds
local chromeKeyMap = hs.hotkey.modal.new()

-- cmd + shift + ] -> ctrl + tab
-- cmd + shift + [ -> ctrl + shift + tab
-- chromeKeyMap:bind({'cmd', 'shift'}, ']', keyCode(nil, {'ctrl', 'tab'}))
-- chromeKeyMap:bind({'cmd', 'shift'}, '[', keyCode(nil, {'ctrl', 'shift', 'tab'}))

local function appTitle()
   app = hs.application.frontmostApplication()
   if app ~= nil then
      return app:title()
   end
end

-- Add keybindings each Applications
local function handleAppActivatedEvent(appName, eventType, appObject)
   if (eventType == hs.application.watcher.activated) then
      if appTitle() ~= "Google%sChrome" then
         chromeKeyMap:enter()
      else
         chromeKeyMap:exit()
      end
   end
end

local appsWatcher = hs.application.watcher.new(handleAppActivatedEvent)
appsWatcher:start()

-- Mouse pointer を Display に jump させる
local function moveMousePointerOnDisplay()
   displayCoOrdinates = {}
   displayCoOrdinates['x'] = 2390
   displayCoOrdinates['y'] = 610
   hs.mouse.setAbsolutePosition(displayCoOrdinates)
end

-- Mouse pointer を MacOS に jump させる
local function moveMousePointerOnMac()
   displayCoOrdinates = {}
   displayCoOrdinates['x'] = 600
   displayCoOrdinates['y'] = 300
   hs.mouse.setAbsolutePosition(displayCoOrdinates)
end

hs.hotkey.bind({'cmd', 'shift' }, '1', moveMousePointerOnDisplay)
hs.hotkey.bind({'cmd', 'shift' }, '2', moveMousePointerOnMac)

karabinerDefaultProfile = "Default profile"
karabinerKinesisProfile = "Kinesis"

-- NOTE: 258 is Cherry MX Red version, 516 is Cherry MX Brown version. These are both Kinesis Advantage2
kinesisProductIDs = { 258, 516 }

-- NOTE: 10730 is Cherry MX Red version, 1452 is Cherry MX Brown version. These are both Kinesis Advantage2
kinesisVendorIDs = { 10730, 1452 }

karabinerCliPath = "/Library/Application\\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"

local function has_value(tabl, val)
   for _, value in ipairs(tabl) do
      if value == val then
         return true
      end
   end

   return false
end

local function changeKarabinerProfile(tbl)
   cmd = ""

   if tbl["eventType"] == "added" then
      -- if tbl["vendorID"] == kinesisVendorID and tbl["productID"] == kinesisProductID then
      if has_value(kinesisProductIDs, tbl["productID"]) and has_value(kinesisVendorIDs, tbl["vendorID"]) then
         cmd = string.format("%s --select-profile '%s'", karabinerCliPath, karabinerKinesisProfile)
      end
   end

   if tbl["eventType"] == "removed" then
      if has_value(kinesisProductIDs, tbl["productID"]) and has_value(kinesisVendorIDs, tbl["vendorID"]) then
         cmd = string.format("%s --select-profile '%s'", karabinerCliPath, karabinerDefaultProfile)
      end
   end

   if cmd ~= "" then
      hs.alert.show(cmd)
      os.execute(cmd)
   end
end

usbWatcher = hs.usb.watcher.new(changeKarabinerProfile)
usbWatcher:start()
