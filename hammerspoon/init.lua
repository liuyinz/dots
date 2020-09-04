-- Default Setting
hs.hotkey.alertDuration = 0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

-- Install & Load SpoonInstall.spoon
if not hs.spoons.isLoaded("SpoonInstall") then
    if not hs.spoons.isInstalled("SpoonInstall") then
        os.execute(
            "curl -fLo ./Spoons/tmp.zip  --create-dirs https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip && cd Spoons && unzip -q tmp.zip && rm tmp.zip")
    end
    hs.loadSpoon("SpoonInstall")
end

-- Define default Spoons which will be loaded later
hspoon_list = {"Calendar", "WinWin", "KSheet", "HSKeybindings"}
-- Install & Load Spoon
for _, v in pairs(hspoon_list) do spoon.SpoonInstall:andUse(v) end

local baseKey = {"cmd", "ctrl"}
local hyperKey = {"cmd", "shift", "ctrl"}

-- Lockscreen
hs.hotkey.bind(baseKey, 'L', 'LockScreen',
               function() hs.caffeinate.lockScreen() end)

-- Window Switcher
-- switcher = hs.window.switcher.new(hs.window.filter.new():setAppFilter('Emacs', {allowRoles = '*', allowTitles = 1}),
--   {
--     showTitles = false,
--     thumbnailSize = 110,
--     showSelectedThumbnail = false,
--     backgroundColor = {0, 0, 0, 0.9},
--     highlightColor = {0.3, 0.3, 0.3, 0.8},
--   }
-- )
--
-- hs.hotkey.bind('alt','tab','Next window',function() switcher:next() end,nil,function() switcher:next() end)
-- hs.hotkey.bind('alt-shift','tab','Prev window',function() switcher:previous() end ,nil, function() switcher:previous() end)

-- Spoons Keybindings
hs.hotkey.bind(hyperKey, "R", 'HS Reload', function() hs.reload() end)
hs.hotkey.bind(hyperKey, "C", 'HS Console', function() hs.toggleConsole() end)
hs.hotkey.bind(hyperKey, "U", 'HS Update',
               function() spoon.SpoonInstall:asyncUpdateAllRepos() end)
hs.hotkey.bind(hyperKey, "H", 'HS API', function()
    hs.doc.hsdocs.forceExternalBrowser(true)
    hs.doc.hsdocs.moduleEntitiesInSidebar(true)
    hs.doc.hsdocs.help()
end)

-- Cheatsheet
-- hs.hotkey.bind(baseKey, 'C', 'Toggle Cheatsheet',    function() spoon.KSheet:toggle() end)
-- hs.hotkey.bind(baseKey, 'F', 'Toggle HSKeybindings', function() spoon.HSKeybindings:toggle() end)

-- WinWin Keybindings
hs.hotkey.bind(baseKey, 'H', 'Resize halfleft',
               function() spoon.WinWin:moveAndResize('halfleft') end)
hs.hotkey.bind(baseKey, 'J', 'Resize halfdown',
               function() spoon.WinWin:moveAndResize('halfdown') end)
hs.hotkey.bind(baseKey, 'K', 'Resize halfup',
               function() spoon.WinWin:moveAndResize('halfup') end)
hs.hotkey.bind(baseKey, 'L', 'Resize halfright',
               function() spoon.WinWin:moveAndResize('halfright') end)
hs.hotkey.bind(baseKey, 'Y', 'Resize cornerNW',
               function() spoon.WinWin:moveAndResize('cornerNW') end)
hs.hotkey.bind(baseKey, 'U', 'Resize cornerSW',
               function() spoon.WinWin:moveAndResize('cornerSW') end)
hs.hotkey.bind(baseKey, 'I', 'Resize cornerSE',
               function() spoon.WinWin:moveAndResize('cornerSE') end)
hs.hotkey.bind(baseKey, 'O', 'Resize cornerNE',
               function() spoon.WinWin:moveAndResize('cornerNE') end)
hs.hotkey.bind(baseKey, 'M', 'Resize maximize',
               function() spoon.WinWin:moveAndResize('maximize') end)
hs.hotkey.bind(baseKey, 'N', 'Resize minimize',
               function() spoon.WinWin:moveAndResize('minimize') end)
hs.hotkey.bind(baseKey, 'space', 'Resize fullscreen',
               function() spoon.WinWin:moveAndResize('fullscreen') end)
hs.hotkey.bind(baseKey, 'left', 'ToScreen left',
               function() spoon.WinWin:moveToScreen("left") end)
hs.hotkey.bind(baseKey, 'right', 'ToScreen right',
               function() spoon.WinWin:moveToScreen("right") end)
hs.hotkey.bind(baseKey, 'up', 'ToScreen up',
               function() spoon.WinWin:moveToScreen("up") end)
hs.hotkey.bind(baseKey, 'down', 'ToScreen down',
               function() spoon.WinWin:moveToScreen("down") end)
