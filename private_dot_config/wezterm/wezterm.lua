local wezterm = require("wezterm")
local config = wezterm.config_builder()

local utils = require("custom-utils")

config.automatically_reload_config = true

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
  brightness = utils.ui.is_light and 0.87 or 0.58,
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
config.initial_rows = 28

--- Simpler, bottom tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.skip_close_confirmation_for_processes_named = {
  "bash",
  "bash.exe",
  "sh",
  "zsh",
  "fish",
  "tmux",
  "nu",
  "cmd.exe",
  "wsl.exe",
  "wslhost.exe",
  "pwsh.exe",
  "powershell.exe",
}

require("color-theme")(config)

---
--- Platform specific
---

local TAB_TYPE_ICON = utils.BASE_TAB_TYPE_ICON

if utils.is_darwin then
  config.window_decorations =
    "TITLE | RESIZE | MACOS_FORCE_ENABLE_SHADOW | MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR"

  config.window_background_opacity = 0.96
  config.macos_window_background_blur = 32

  TAB_TYPE_ICON = utils.merge_fields(TAB_TYPE_ICON, {
    ["local"] = " ",
  })
end

if utils.is_linux then
  config.window_background_opacity = 0.78
  config.wayland_window_background_blur = true

  TAB_TYPE_ICON = utils.merge_fields(TAB_TYPE_ICON, {
    ["local"] = " ",
  })
end

if utils.is_windows then
  config.window_background_opacity = 0
  config.win32_system_backdrop = "Tabbed"

  TAB_TYPE_ICON = utils.merge_fields(TAB_TYPE_ICON, {
    ["local"] = "󰍲 ",
    ["wsl"] = " ",
  })

  --- Set this in local-overrides if necessary
  --- Start in WSL by default (slow cold start)
  -- config.default_domain = "WSL:archlinux"
  -- config.default_prog = { "C:\\cygwin64\\bin\\bash.exe", "--login", "-i" }
  -- config.default_cwd = "~" --- Need to set this explicitly to ensure it's resolving correctly in both WSL and local instances
end

--- Shows a different icon prefix in the tabs for each tab type (ssh, local, wsl...)
--- Icons are platform specific.
wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
  local domain = tab.active_pane.domain_name or "local"
  local domain_type = (domain:match("(.*):") or ""):lower()

  return {
    {
      Text = string.format(
        " %s %s ",
        TAB_TYPE_ICON[domain] or TAB_TYPE_ICON[domain_type] or TAB_TYPE_ICON["unknown"],
        tab.active_pane.title
      ),
    },
  }
end)

--- Configure keybindings
--- Pretty self-explanatory, innit'?
config.keys = require("keys")
config.key_tables = {
  peek_mode = require("peek_to_alternate").peek_map,
}

--- Import local overrides file if it exists
local exists, override = pcall(require, "local-overrides")
if exists then
  override(config)
end

return config
