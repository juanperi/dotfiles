-- Install SpoonInstall if needed
local spoon_install_path = hs.spoons.resourcePath("Spoons")
if
  not pcall(function()
    hs.fs.dir(spoon_install_path .. "/SpoonInstall.spoon")
  end)
then
  hs.http.asyncGet(
    "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip",
    nil,
    function(status, body, headers)
      local zipfile = spoon_install_path .. "/SpoonInstall.spoon.zip"
      io.open(zipfile, "w"):write(body):close()
      hs.execute(string.format("/usr/bin/unzip -d %s %s", spoon_install_path, zipfile))
      hs.execute(string.format("/bin/rm '%s'", zipfile))
    end
  )
end

local hyper = {"ctrl", "alt", "cmd"}
hs.application.enableSpotlightForNameSearches(true)

local function focus_window(window)
  window:focus()
  if hs.window.focusedWindow() ~= window then
    -- Some cases with apps having windows on multiple monitors require
    -- us to try again (?)
    window:focus()
  end
end

-- Spoons --
hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall:andUse("MicMute", {
  hotkeys = {
    toggle = { hyper, "a" },
    latch_timeout = 0.75
  }
})

---

--------------------------------
-- START VIM CONFIG
--------------------------------
local VimMode = hs.loadSpoon("VimMode")
local vim = VimMode:new()

-- Configure apps you do *not* want Vim mode enabled in
-- For example, you don't want this plugin overriding your control of Terminal
-- vim
vim
  :disableForApp('Code')
  :disableForApp('zoom.us')
  :disableForApp('iTerm')
  :disableForApp('iTerm2')
  :disableForApp('Terminal')
  :disableForApp('Alacritty')
  :disableForApp('Obsidian')

-- If you want the screen to dim (a la Flux) when you enter normal mode
-- flip this to true.
vim:shouldDimScreenInNormalMode(false)

-- If you want to show an on-screen alert when you enter normal mode, set
-- this to true
vim:shouldShowAlertInNormalMode(true)

-- You can configure your on-screen alert font
vim:setAlertFont("Courier New")

-- Enter normal mode by typing a key sequence
vim:enterWithSequence('jj')

-- if you want to bind a single key to entering vim, remove the
-- :enterWithSequence('jk') line above and uncomment the bindHotKeys line
-- below:
--
-- To customize the hot key you want, see the mods and key parameters at:
--   https://www.hammerspoon.org/docs/hs.hotkey.html#bind
--
-- vim:bindHotKeys({ enter = { {'ctrl'}, ';' } })

-----------------j---------------
-- END VIM CONFIG
--------------------------------
