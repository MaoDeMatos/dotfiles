local wezterm = require("wezterm")
local config = wezterm.config_builder()

local utils = require("custom-utils")

config.automatically_reload_config = false

---
--- General & window settings
---
config.audible_bell = "Disabled"

--- Use Medium font weight for better legibility when using Light mode
config.font = wezterm.font("Iosevka Term", {
  weight = utils.ui.is_dark and "Regular" or "Medium",
})
config.font_size = 12

--- Should be replaced at some point by `inactive_font_opacity`
config.inactive_pane_hsb = {
  brightness = utils.ui.is_light and 0.87 or 0.67,
}

--- Remove padding for clean TUIs
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

--- Enable resizing by cell increments only to avoid gaps around TUIs
config.use_resize_increments = false

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
  config.window_decorations =
  "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW | MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"

  config.window_background_opacity = 0.96
  config.macos_window_background_blur = 32
end

if utils.is_linux then
  config.window_background_opacity = 0.78
  config.wayland_window_background_blur = true
end

if utils.is_windows then
  config.window_background_opacity = 0.96
  config.win32_system_backdrop = "Acrylic"
end

--- Configure keybindings
--- Pretty self-explanatory, innit'?
config.keys = require("keys")
config.key_tables = {
  peek_mode = require("peek_to_alternate").peek_map
}

--- Import local overrides file if it exists
local exists, override = pcall(require, "local-overrides")
if exists then
  override(config)
end

return config
