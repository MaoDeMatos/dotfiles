local wezterm = require("wezterm")
local enable_peek_mode = require("peek_to_alternate").enable_peek_mode

--- Must respect wezterm's 'config.keys' format
return {
  { key = "F12", action = enable_peek_mode },

  --- Manage panes & tabs
  { mods = "SHIFT|ALT", key = "d", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { mods = "CTRL|SHIFT", key = "d", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { mods = "CTRL|SHIFT", key = "w", action = wezterm.action.CloseCurrentPane({ confirm = true }) }, -- Also closes the tab if only one pane
  { mods = "CTRL|SHIFT", key = "t", action = wezterm.action.SpawnTab("CurrentPaneDomain") },

  --- Move between panes
  { mods = "SHIFT|ALT", key = "DownArrow", action = wezterm.action.ActivatePaneDirection("Down") },
  { mods = "SHIFT|ALT", key = "UpArrow", action = wezterm.action.ActivatePaneDirection("Up") },
  { mods = "SHIFT|ALT", key = "LeftArrow", action = wezterm.action.ActivatePaneDirection("Left") },
  { mods = "SHIFT|ALT", key = "RightArrow", action = wezterm.action.ActivatePaneDirection("Right") },

  --- Test: Macos Natural Text editing mode
  { mods = "ALT", key = "LeftArrow", action = wezterm.action.SendKey({ mods = "ALT", key = "b" }) },
  { mods = "ALT", key = "RightArrow", action = wezterm.action.SendKey({ mods = "ALT", key = "f" }) },
}
