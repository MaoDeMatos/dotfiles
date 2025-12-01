local wezterm = require("wezterm")
local config = wezterm.config_builder()

local utils = require("custom-utils")

config.automatically_reload_config = true

---
--- General & window settings
---
config.font_size = 12
config.font = wezterm.font({
  -- family = "Fira Code", --- If there's any issues with Iosevka
  family = "Iosevka Term",
})

--- Remove padding for clean TUIs
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

--- Default window size
config.initial_cols = 128
config.initial_rows = 32

--- Simpler, bottom tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

---
--- Platform specific
---

if utils.is_darwin then
  config.window_decorations = "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW | MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"

  config.window_background_opacity = 0.92
  config.macos_window_background_blur = 32
end

if utils.is_linux then
  config.window_background_opacity = 0.72
  config.kde_window_background_blur = true
end

if utils.is_windows then
  config.window_background_opacity = 0.96
  config.win32_system_backdrop = "Acrylic"
end

--- Configure keybindings
--- Pretty self-explanatory, innit'?
config.keys = require("keys")

--- Import local overrides file if it exists
local exists, override = pcall(require, "local-overrides")
if exists then
  override(config)
end

return config
